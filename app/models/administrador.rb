class Administrador < ActiveRecord::Base
  before_destroy :check_last_admin?, :check_admin?
  before_save :check_admin?

  attr_accessor :current_user

  belongs_to :user, :inverse_of => :administradores
  belongs_to :empresa, :inverse_of => :administradores

  has_many :users, :foreign_key => "user_id"
  has_many :empresas, :foreign_key => "empresa_id"

  validates :user, presence: true
  validates :empresa, presence: true
  validates :user_id, uniqueness: {scope: :empresa_id, message: "já é administrador dessa empresa"}

  # Define se o user está altorizado a operações delicadas como deletes
  def authorize(u)
    if u.blank?
      return false
    end
    if !new_record?
      if (user.id != u.id and empresa.sou_admin(u))
        return false
      elsif user.id == u.id
        return true
      end
    else
      return true
    end
  end

  private

  def check_last_admin?
    @qtdAdmins = Administrador.where(empresa_id: empresa.id).count
    if @qtdAdmins <= 1
      self.errors.add(:base, "Não é possível remover adminstração pois você é o último administrador da empresa <b>#{empresa.nome}</b>")
      throw :abort
    end
    return true
  end

  def check_admin?
    if !authorize current_user
      self.errors.add(:base, "Você não é adminstrador dessa empresa")
      throw :abort
    end
    return true
  end
end
