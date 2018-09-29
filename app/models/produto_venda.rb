class ProdutoVenda < ApplicationRecord
  belongs_to :venda
  belongs_to :produto

  validates :quantidade, :numericality => {greater_tahn: 0}, presence: true
end
