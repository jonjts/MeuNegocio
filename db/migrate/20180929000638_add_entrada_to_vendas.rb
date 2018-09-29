class AddEntradaToVendas < ActiveRecord::Migration[5.0]
  def up
    add_column :vendas, :entrada, :decimal, :precision => 15, :scale => 2, null: false, default: 0.00
  end

  def down
    remove_column :vendas, :entrada
  end
end
