class Cliente < ApplicationRecord
  require "cpf_cnpj"

  belongs_to :empresa
  has_many :telefones, dependent: :destroy, :inverse_of => :cliente
  has_many :enderecos, dependent: :destroy, :inverse_of => :cliente

  accepts_nested_attributes_for :telefones, :allow_destroy => true
  accepts_nested_attributes_for :enderecos, :allow_destroy => true

  validates :nome, presence: true
  validate :valid_cpf_rg
  validates :cpf, uniqueness: {scope: :user_id}, :allow_blank => true

  private

  def valid_cpf_rg
    unless cpf.blank?
      unless CPF.valid?(cpf)
        errors.add(:cpf, "inválido")
      end
    end
    unless rg.blank?
      self.rg = rg <= 0 ? nil : rg
      if !Cliente.all.where("rg = ? AND user_id = ? AND id <> ?", rg, user, id).empty?
        errors.add(:rg, "já está em uso")
      end
    end
  end
end
