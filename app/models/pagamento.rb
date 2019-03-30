class Pagamento < ApplicationRecord
  belongs_to :venda

  validates :numero_parcela, :numericality => {greater_tahn: 0}, presence: true
  validates :data_pagamento, presence: true
end
