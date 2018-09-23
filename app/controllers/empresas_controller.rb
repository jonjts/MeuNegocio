class EmpresasController < ApplicationController
  #before_action :authorize!, except: [:new, :create, :show, :index]

  def select
    cookies.encrypted[:empresa_selecionada] = (params[:empresa_id])
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
end
