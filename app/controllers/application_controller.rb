class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_empresa_session

  def empresa_selecionada
    if cookies.encrypted[:empresa_selecionada].blank?
      return Empresa.new
    end
    return Empresa.find(cookies.encrypted[:empresa_selecionada])
  end

  private

  def set_empresa_session
    if user_signed_in? and empresa_selecionada.blank?
      if current_user.empresas.blank?
        flash[:info] = "Crie uma nova empresa para começar"
        redirect_to new_minha_empresa_path
        return
      else
        cookies.encrypted[:empresa_selecionada] = current_user.empresas.first.id
        flash[:info] = "Empresa '#{empresa_selecionada.nome}' selecionada"
        redirect_to root_path
        return
      end
    end
  end
end
