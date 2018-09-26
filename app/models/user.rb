class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  validates :name, presence: true

  has_many :clientes
  has_many :minhas_empresas, dependent: :destroy, :foreign_key => "user_id"
  has_many :empresas, :through => :minhas_empresas
  has_many :administradores, dependent: :destroy, :foreign_key => "user_id"
  has_many :empresas_administradas, :through => :administradores

  def identificacao
    "#{self.name}, #{self.email}"
  end
end
