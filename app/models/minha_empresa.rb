class MinhaEmpresa < ActiveRecord::Base
  after_create :add_admin
  self.table_name = "minhas_empresas"
  belongs_to :user, :inverse_of => :minhas_empresas
  belongs_to :empresa, :inverse_of => :minhas_empresas

  has_many :administradores, dependent: :destroy, :foreign_key => "empresa_id"

  validates :user_id, presence: true
  validates :empresa, presence: true
  # validates :user_id, uniqueness: {scope: :empresa_id}

  private

  def add_admin
    # Ao criar, adiciona o cara como admin
    @admin = Administrador.new
    @admin.user = self.user
    @admin.empresa = self.empresa
    @admin.save!
  end
end
