class Venda < ApplicationRecord
  scope :by_empresa, lambda { |empresa_id| where(" cliente_id IN (SELECT cliente_id FROM clientes WHERE empresa_id = ?)", empresa_id) }

  belongs_to :cliente

  has_many :produtos_vendas
  has_many :servicos_vendas

  accepts_nested_attributes_for :produtos_vendas, :allow_destroy => true
  accepts_nested_attributes_for :servicos_vendas, :allow_destroy => true
end
