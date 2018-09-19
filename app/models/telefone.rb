class Telefone < ActiveRecord::Base
  belongs_to :cliente, :inverse_of => :telefones

  validates :numero, uniqueness: {scope: [:cliente]}

  validates :cliente, presence: true
  validates :numero, presence: true, phone: true
end
