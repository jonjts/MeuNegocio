class MinhaEmpresa < ActiveRecord::Base
  after_create :add_admin
  before_destroy :check_admin?

  attr_accessor :can_create_admin
  attr_accessor :current_user

  self.table_name = "minhas_empresas"
  belongs_to :user, :inverse_of => :minhas_empresas
  belongs_to :empresa, :inverse_of => :minhas_empresas

  has_many :administradores, dependent: :destroy, :foreign_key => "empresa_id"

  validates :user_id, presence: true
  validates :empresa, presence: true
  validates :user_id, uniqueness: {scope: :empresa_id, message: "já é membro dessa empresa"}

  accepts_nested_attributes_for :empresa

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

  def check_admin?
    if !authorize current_user
      self.errors.add(:base, "Tivemos problemas com suas permissões")
      throw :abort
    end
    return true
  end

  def add_admin
    # Ao criar, adiciona o cara como admin
    if can_create_admin
      @admin = Administrador.new
      @admin.user = self.user
      @admin.empresa = self.empresa
      @admin.current_user = current_user
      if !@admin.save!
        self.errors.add(:base, @admin.errors.full_messages.to_sentence)
      end
    end
  end
end
