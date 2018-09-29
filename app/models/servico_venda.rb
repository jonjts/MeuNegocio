class ServicoVenda < ApplicationRecord
  belongs_to :venda
  belongs_to :servico

  validates :quantidade, :numericality => {greater_tahn: 0}, presence: true
end
