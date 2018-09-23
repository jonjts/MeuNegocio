class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_empresa_session, unless: :devise_controller?

  def empresa_selecionada
    if cookies.encrypted[:empresa_selecionada].blank?
      return Empresa.new
    end
    @empresa = Empresa.where(id: cookies.encrypted[:empresa_selecionada])
    if @empresa.blank?
      cookies.encrypted[:empresa_selecionada] = nil
      set_empresa_session
    end
    return @empresa.first
  end

  def has_empresa_selecionada
    return !cookies[:empresa_selecionada].blank?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  private

  def set_empresa_session
    if user_signed_in? and !has_empresa_selecionada
      if current_user.empresas.blank?
        flash[:info] = "Crie uma nova empresa para começar"
        redirect_to new_minha_empresa_path
        return
      else
        cookies.encrypted[:empresa_selecionada] = current_user.empresas.first.id
        flash[:info] = "Empresa <b>#{empresa_selecionada.nome}</b> selecionada"
        redirect_to root_path
        return
      end
    end
  end
end
