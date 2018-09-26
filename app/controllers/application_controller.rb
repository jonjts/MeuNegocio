class ApplicationController < ActionController::Base
  helper_method :has_empresa_selecionada?, :empresa_selecionada
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_empresa_session, unless: :devise_controller?

  def empresa_selecionada
    if !has_empresa_selecionada?
      return Empresa.new
    end
    @empresa = Empresa.where(id: cookies.signed[:empresa_selecionada])
    #checa se a empresa ainda pertence ao usuario
    if @empresa.blank?
      cookies.signed[:empresa_selecionada] = nil
      set_empresa_session
    end
    return @empresa.first
  end

  def has_empresa_selecionada?
    id = cookies.signed[:empresa_selecionada]
    return !(id.blank? || current_user.empresas.where(id: id).blank?)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  private

  def set_empresa_session
    if user_signed_in? and !has_empresa_selecionada?
      if current_user.empresas.blank?
        flash[:info] = "Crie uma nova empresa para começar"
        redirect_to new_minha_empresa_path
        return
      else
        cookies.signed[:empresa_selecionada] = current_user.empresas.first.id
        flash[:info] = "Empresa <b>#{empresa_selecionada.nome}</b> selecionada"
        redirect_to root_path
        return
      end
    end
  end
end
