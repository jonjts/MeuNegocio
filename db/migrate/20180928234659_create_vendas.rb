class CreateVendas < ActiveRecord::Migration[5.0]
  def up
    create_table :vendas do |t|
      t.references :cliente, foreign_key: true, null: false
      t.decimal :taxa_adicional, :precision => 15, :scale => 2, null: false
      t.text :descricao
      t.decimal :desconto, :precision => 15, :scale => 2, null: false, default: 0.00

      t.timestamps
    end
  end

  def down
    drop_table :vendas
  end
end
