class ClientesController < ApplicationController
  def index
    @clientes = current_user.clientes.
      paginate(:page => params[:page], :per_page => 10).order(nome: :asc)
    respond_to do |format|
      format.html
      format.json { render :json => @clientes }
    end
  end

  def new
    @cliente = Cliente.new
  end

  def create
    @cliente = Cliente.new(param_cliente)
    @cliente.user = current_user
    if @cliente.save
      flash[:success] = "Cliente adicionado com sucesso"
      redirect_to clientes_path
    else
      flash[:danger] = @cliente.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    set_cliente
    @cliente.destroy
    flash["success"] = "Cliente removido com sucesso"
    redirect_to clientes_path
  end

  def edit
    @cliente = Cliente.find(params[:id])
  end

  def update
    set_cliente
    puts param_cliente
    if @cliente.update(param_cliente)
      flash["success"] = "Cliente alterado com sucesso"
      redirect_to clientes_path
    else
      flash["danger"] = @cliente.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def set_cliente
    @cliente = Cliente.find(params[:id])
  end

  def param_cliente
    return params.require(:cliente).
             permit(:id, :nome, :cpf, :rg)
  end
end