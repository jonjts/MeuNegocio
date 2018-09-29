class Servico < ApplicationRecord
  default_scope { where(removido_em: nil) }

  attr_accessor :currency_valor_venda

  belongs_to :empresa

  has_many :servicos_vendas

  validates :empresa, presence: true
  validates :nome, presence: true
  validates :valor_venda, presence: true
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
