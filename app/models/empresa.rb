class Empresa < ActiveRecord::Base
  before_validation :check_admin
  before_destroy :check_admin, prepend: true

  attr_accessor :current_user

  belongs_to :criado_por, class_name: "User", foreign_key: "criado_por"
  has_many :minhas_empresas, :foreign_key => "empresa_id", :inverse_of => :empresa, dependent: :destroy
  has_many :users, :through => :minhas_empresas
  has_many :administradores, dependent: :destroy, :foreign_key => "empresa_id", :inverse_of => :empresa
  has_many :clientes
  has_many :produtos
  has_many :servicos

  validates :nome, presence: true
  validates :criado_por, presence: true

  accepts_nested_attributes_for :minhas_empresas
  accepts_nested_attributes_for :criado_por

  def sou_admin(current_user)
    if current_user.nil?
      return false
    end
    @administradores = self.administradores.
      where(user_id: current_user.id).take
    !@administradores.blank?
  end

  private

  def check_admin
    if !new_record? and !sou_admin(current_user)
      self.errors.add(:base, "Usuário não é adminstrador")
      throw :abort
    end
    return true
  end
end
