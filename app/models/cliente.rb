class Cliente < ApplicationRecord
  require "cpf_cnpj"

  default_scope { where(removido_em: nil) }

  belongs_to :empresa
  has_many :telefones, dependent: :destroy, :inverse_of => :cliente
  has_many :enderecos, dependent: :destroy, :inverse_of => :cliente
  has_many :vendas, :inverse_of => :cliente

  accepts_nested_attributes_for :telefones, :allow_destroy => true
  accepts_nested_attributes_for :enderecos, :allow_destroy => true

  validates :nome, presence: true
  validate :valid_cpf_rg
  validates :cpf, uniqueness: {scope: :empresa_id}, :allow_blank => true
  validates :rg, uniqueness: {scope: :empresa_id}, :allow_blank => true

  def destroy
    update_attribute(:removido_em, DateTime.now)
  end

  private

  def valid_cpf_rg
    unless cpf.blank?
      unless CPF.valid?(cpf)
        errors.add(:cpf, "inválido")
      end
    end
  end
end
