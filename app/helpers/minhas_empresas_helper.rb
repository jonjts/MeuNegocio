module MinhasEmpresasHelper
  def sou_admin(empresa)
    if empresa.sou_admin(current_user)
      return content_tag :span, "admin", class: "badge badge-info", title: "Você é adminstrador dessa empresa"
    end
  end
end
