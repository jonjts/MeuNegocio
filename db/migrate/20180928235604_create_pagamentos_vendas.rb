class CreatePagamentosVendas < ActiveRecord::Migration[5.0]
  def up
    create_table :pagamentos_vendas do |t|
      t.references :venda, foreign_key: true, null: false
      t.integer :numero_parcela, null: false
      t.decimal :valor, :precision => 15, :scale => 2, null: false
      t.date :data_pagamento, null: false
      t.timestamp :pago_em

      t.timestamps
    end
  end

  def down
    drop_table :pagamentos_vendas
  end
end
