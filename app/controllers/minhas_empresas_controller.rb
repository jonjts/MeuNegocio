class MinhasEmpresasController < ApplicationController
  skip_before_action :set_empresa_session, only: [:new, :create]

  def index
    @empresas = current_user.empresas.
      paginate(:page => params[:page], :per_page => 20).order(nome: :asc)
    respond_to do |format|
      format.html
      format.json { render :json => @empresas }
    end
  end

  def new
    @minhaEmpresa = MinhaEmpresa.new
  end

  def create
    @permitted = param_minha_empresa
    @minha_empresa = MinhaEmpresa.new(@permitted)
    @minha_empresa.empresa.criado_por = current_user
    @minha_empresa.empresa.current_user = current_user
    @minha_empresa.user = current_user
    if @minha_empresa.save!
      flash[:success] = "Empresa adicionada com sucesso"
      redirect_to minhas_empresas_path
    else
      flash[:danger] = @minha_empresa.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    set_minha_empresa
  end

  private

  def set_minha_empresa
    @minhaEmpresa = MinhaEmpresa.find(params[:id])
  end

  def param_minha_empresa
    return params.require(:minha_empresa).
             permit(:id, :user_id, :empresa_id,
                    empresa_attributes: [:id, :nome])
  end
end
