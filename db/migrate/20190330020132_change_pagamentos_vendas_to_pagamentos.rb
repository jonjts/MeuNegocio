class ChangePagamentosVendasToPagamentos < ActiveRecord::Migration[5.0]
  def up
    rename_table :pagamentos_vendas, :pagamentos
  end

  def down
    rename_table :pagamentos, :pagamentos_vendas
  end
end
