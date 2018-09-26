module ApplicationHelper
  def sou_admin(empresa)
    if empresa.blank?
      return ""
    end
    if empresa.sou_admin(current_user)
      tag = capture do
        concat empresa.nome
        concat " "
        concat content_tag :span, "admin", class: "badge badge-info", title: "Você é adminstrador dessa empresa"
      end
      return tag
    end
    return empresa.nome
  end

  def empresas_para_selecionar
    current_user.empresas.where.not(id: empresa_selecionada().id).order(:nome)
  end
end
