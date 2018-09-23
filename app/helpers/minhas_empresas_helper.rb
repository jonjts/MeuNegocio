module MinhasEmpresasHelper
  def remover_admin(empresa)
    @adimins = Administrador.where(empresa_id: empresa.id, user_id: current_user.id)
    if @adimins.blank?
      return ""
    else
      return link_to fa_icon("lock"), administrador_remover_path(@adimins.first), method: :delete, "data-confirm": "Sair da administração?", class: "btn btn-outline-danger btn-xs", data: {toggle: "tooltip", placement: "top"}, title: "Sair da administração"
    end
  end
end
