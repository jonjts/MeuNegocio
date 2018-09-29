class VendasController < ApplicationController
  def index
    @vendas = Venda.by_empresa(empresa_selecionada.id).
      paginate(:page => params[:page], :per_page => 20).order(created_at: :asc)
    respond_to do |format|
      format.html
      format.json { render :json => @vendas }
    end
  end

  def new
    @venda = Venda.new
  end
end
