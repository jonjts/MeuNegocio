class ProdutosController < ApplicationController
  def index
    @produtos = empresa_selecionada.produtos.
      paginate(:page => params[:page], :per_page => 20).order(nome: :asc)
    respond_to do |format|
      format.html
      format.json { render :json => @produtos }
    end
  end

  def new
    @produto = Produto.new
  end

  def create
    @produto = Produto.new(param_produto)
    @produto.empresa = empresa_selecionada
    if @produto.save
      flash[:success] = "Produto adicionado com sucesso"
      redirect_to produtos_path
    else
      flash[:danger] = @produto.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    set_produto
  end

  def update
    set_produto
    if @produto.update(param_produto)
      flash[:success] = "Produto alterado com sucesso"
      redirect_to produtos_path
    else
      flash[:danger] = @produto.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    set_produto
    if @produto.destroy
      flash[:success] = "Produto removido com sucesso"
      redirect_to produtos_path
    else
      flash[:danger] = @produto.errors.full_messages.to_sentence
      render :index
    end
  end

  private

  def set_produto
    @produto = Produto.find(params[:id])
  end

  def param_produto
    return params.require(:produto).
             permit(:id, :nome, :currency_valor_venda, :currency_valor_compra,
                    :situacao, :quantidade, :descricao)
  end
end
