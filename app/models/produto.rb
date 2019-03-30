class Produto < ApplicationRecord
  default_scope { where(removido_em: nil) }

  attr_accessor :currency_valor_venda
  attr_accessor :currency_valor_compra

  belongs_to :empresa
  belongs_to :venda
  has_many :produtos_vendas

  validates :nome, presence: true
  validates :empresa, presence: true
  validates :valor_venda, :numericality => {greater_than: 0}, presence: true
  validates :quantidade, :numericality => {greater_tahn: 0}, presence: true
  validates :situacao, inclusion: {in: [true, false]}

  def currency_valor_venda
    unless valor_venda.blank?
      return helper.number_to_currency(valor_venda, :unit => "", format: "%u %n").delete(" ")
    end
    return ""
  end

  def currency_valor_venda=(str)
    unless str.blank?
      self.valor_venda = BigDecimal.new(str.match(/(\d.+)/)[1].gsub(",", "."))
    end
  end

  def currency_valor_compra
    unless valor_compra.blank?
      return helper.number_to_currency(valor_compra, :unit => "").delete(" ")
    end
    return ""
  end

  def currency_valor_compra=(str)
    unless str.blank?
      self.valor_compra = BigDecimal.new(str.match(/(\d.+)/)[1].gsub(",", "."))
    end
  end

  def destroy
    update_attribute(:removido_em, DateTime.now)
  end

  private

  def helper
    @helper ||= Class.new do
      include ActionView::Helpers::NumberHelper
    end.new
  end
end
