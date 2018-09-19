class Cliente < ApplicationRecord
  require "cpf_cnpj"

  belongs_to :user

  validates :nome, presence: true
  validate :valid_cpf_rg
  validates :cpf, uniqueness: {scope: :user_id}

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
