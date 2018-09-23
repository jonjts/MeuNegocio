class Administrador < ActiveRecord::Base
  belongs_to :user, :inverse_of => :administradores
  belongs_to :empresa, :inverse_of => :administradores

  has_many :users, :foreign_key => "user_id"
  has_many :empresas, :foreign_key => "empresa_id"

  validates :user, presence: true
  validates :empresa, presence: true
end
