class ServicosController < ApplicationController
  def index
    @servicos = empresa_selecionada.servicos.
      paginate(:page => params[:page], :per_page => 20).order(nome: :asc)
    respond_to do |format|
      format.html
      format.json { render :json => @servicos }
    end
  end

  def new
    @servico = Servico.new
  end

  def create
    @servico = Servico.new(param_servico)
    @servico.empresa = empresa_selecionada
    if @servico.save
      flash[:success] = "Serviço adicionado com sucesso"
      redirect_to servicos_path
    else
      flash[:danger] = @servico.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    set_servico
  end

  def update
    set_servico
    if @servico.update(param_servico)
      flash[:success] = "Serviço alterado com sucesso"
      redirect_to servicos_path
    else
      flash[:danger] = @servico.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    set_servico
    if @servico.destroy
      flash[:success] = "Serviço removido com sucesso"
      redirect_to servicos_path
    else
      flash[:danger] = @servico.errors.full_messages.to_sentence
      render :index
    end
  end

  private

  def set_servico
    @servico = Servico.find(params[:id])
  end

  def param_servico
    return params.require(:servico).
             permit(:id, :nome, :currency_valor_venda,
                    :situacao, :descricao)
  end
end
