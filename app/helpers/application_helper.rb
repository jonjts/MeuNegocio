module ApplicationHelper
  def empresa_selecionada
    if cookies.encrypted[:empresa_selecionada].blank?
      return Empresa.new
    end
    return Empresa.find(cookies.encrypted[:empresa_selecionada])
  end
end
