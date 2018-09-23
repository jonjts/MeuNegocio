class Administrador < ActiveRecord::Base
  #before_destroy :check_last_admin?, prepend: true

  belongs_to :user, :inverse_of => :administradores
  belongs_to :empresa, :inverse_of => :administradores

  has_many :users, :foreign_key => "user_id"
  has_many :empresas, :foreign_key => "empresa_id"

  validates :user, presence: true
  validates :empresa, presence: true

  private

  def check_last_admin?
    @qtdAdmins = Administrador.where(empresa_id: empresa.id).count
    if @qtdAdmins <= 1
      self.errors.add(:base, "Não é possível remover adminstração pois você é o último administrador da empresa <b>#{empresa.nome}</b>")
      throw :abort
    end
    return true
  end
end
