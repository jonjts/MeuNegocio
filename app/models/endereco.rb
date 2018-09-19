class Endereco < ApplicationRecord
  belongs_to :cliente, :inverse_of => :enderecos

  validates :cliente, presence: true
  validates :cidade, presence: true
  validate :valid_rua_complemento

  private

  def valid_rua_complemento
    if rua.blank? && complemento.blank?
      errors.add("rua/complemento", "deve ser informado a rua ou o complemento")
    end
  end
end
