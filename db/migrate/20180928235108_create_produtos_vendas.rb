class CreateProdutosVendas < ActiveRecord::Migration[5.0]
  def up
    create_table :produtos_vendas do |t|
      t.references :venda, foreign_key: true, null: false
      t.references :produto, foreign_key: true, null: false
      t.integer :quantidade, null: false

      t.timestamps
    end
  end

  def down
    drop_table :produtos_vendas
  end
end
