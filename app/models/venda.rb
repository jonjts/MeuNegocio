class Venda < ApplicationRecord
  scope :by_empresa, lambda { |empresa_id| where(" cliente_id IN (SELECT cliente_id FROM clientes WHERE empresa_id = ?)", empresa_id) }

  belongs_to :cliente

  validates :cliente, presence: true
  validates :servicos, presence: true, if: :has_produtos?
  validates :produtos, presence: true, if: :has_servicos?
  validates :pagamentos, presence: true

  has_many :produtos, through: :produtos_vendas
  has_many :servicos, through: :servicos_vendas
  has_many :pagamentos

  accepts_nested_attributes_for :produtos, :allow_destroy => true
  accepts_nested_attributes_for :servicos, :allow_destroy => true
  accepts_nested_attributes_for :pagamentos, :allow_destroy => true

  private

  def has_produtos?
    !produtos.blank?
  end

  def has_servicos?
    !servicos.blank?
  end
end
