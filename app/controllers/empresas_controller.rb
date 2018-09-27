class EmpresasController < ApplicationController
  before_action :i_can_see_it!, only: [:show, :edit]
  before_action :authorize!, except: [:new, :create, :show, :index, :edit, :select]

  def add_membro
    @user = User.where(email: params[:email])
    if !@user.blank?
      @minhaEmpresa = MinhaEmpresa.new
      @minhaEmpresa.user = @user.first
      @minhaEmpresa.empresa_id = params[:id]
      @minhaEmpresa.empresa.current_user = current_user
      if @minhaEmpresa.save
        @notice = {"success" => "<b>#{@user.first.identificacao}</b> adicionado como membro"}
      else
        @notice = {"danger" => "Não foi possível adicionar <b>#{@user.first.identificacao}</b><br>#{@minhaEmpresa.errors.full_messages.to_sentence}"}
      end
    else
      @notice = {"danger" => "O usuário <b>#{params[:email]}</b> não foi encontrado"}
    end
    respond_to do |format|
      format.js
    end
  end

  def add_admin
    @user = User.where(email: params[:email])
    if !@user.blank?
      @admin = Administrador.new
      @admin.user = @user.first
      @admin.empresa_id = params[:id]
      @admin.current_user = current_user
      if @admin.save
        @notice = {"success" => "<b>#{@user.first.identificacao}</b> adicionado como administrador"}
      else
        @notice = {"danger" => "Não foi possível adicionar <b>#{@user.first.identificacao}</b><br>#{@admin.errors.full_messages.to_sentence}"}
      end
    else
      @notice = {"danger" => "O usuário <b>#{params[:email]}</b> não foi encontrado"}
    end
    respond_to do |format|
      format.js
    end
  end

  def remove_membro
    @user = User.where(email: params[:email])
    if !@user.blank?
      @user = @user.first
      @minhaEmpresa = MinhaEmpresa.where(user_id: @user.id, empresa_id: params[:id]).first
      @minhaEmpresa.current_user = current_user
      if @minhaEmpresa.destroy
        @notice = {"success" => "<b>#{@user.identificacao}</b> removido da empresa"}
      else
        @notice = {"danger" => "Não foi possível remover <b>#{@user.identificacao}</b><br>#{@minhaEmpresa.errors.full_messages.to_sentence}"}
      end
    else
      @notice = {"danger" => "O usuário <b>#{params[:email]}</b> não foi encontrado"}
    end
    respond_to do |format|
      format.js
    end
  end

  def select
    cookies.signed[:empresa_selecionada] = (params[:empresa_id])
    flash[:info] = "Empresa <b>#{empresa_selecionada.nome}</b> selecionada"
    redirect_to root_path
  end

  def edit
    @empresa = Empresa.find(params[:id])
  end

  def destroy
    set_empresa
    if @empresa.destroy
      flash["success"] = "Empresa removida com sucesso"
    else
      flash["danger"] = @empresa.errors.full_messages.to_sentence
    end
    redirect_to minhas_empresas_path
  end

  def update
    set_empresa
    if @empresa.update(param_empresa)
      flash["success"] = "Empresa alterada com sucesso"
      redirect_to minhas_empresas_path
    else
      flash["danger"] = @empresa.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def set_empresa
    @empresa = Empresa.find(params[:id])
    @empresa.current_user = current_user
  end

  def param_empresa
    return params.require(:empresa).permit(:id, :nome)
  end

  def authorize!
    set_empresa
    unless @empresa.sou_admin current_user
      redirect_to minhas_empresas_path, alert: "Você precisa ser administrador da empresa para continuar" and return
    end
  end

  def i_can_see_it!
    if !(current_user.empresas.include? Empresa.where(id: params[:id]).first)
      redirect_to minhas_empresas_path and return
    end
  end
end
