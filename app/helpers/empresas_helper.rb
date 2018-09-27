module EmpresasHelper
  def create_nome_membro(user, empresa)
    tag = ""
    if user.id == current_user.id
      tag.concat(content_tag :b, "(Você) ")
    end
    tag.concat(user.name + ", " + user.email + " ")
    if empresa.sou_admin user
      tag.concat(content_tag :span, "admin", class: "badge badge-info", title: "Você é adminstrador dessa empresa")
    end
    return raw(tag)
  end

  def membros(empresa)
    @users = empresa.users.order(:name)
  end
end
