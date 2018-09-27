class AdministradoresController < ApplicationController
  def remover
    @admin = Administrador.find(params[:administrador_id])
    @admin.current_user = current_user
    if @admin.destroy
      flash["success"] = "Você não é mais administrador da empresa <b>" + @admin.empresa.nome + "</b>"
      redirect_to minhas_empresas_path
    else
      flash["danger"] = @admin.errors.full_messages.to_sentence
      redirect_to minhas_empresas_path
    end
  end
end
