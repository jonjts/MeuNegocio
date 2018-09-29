class CreateServicosVendas < ActiveRecord::Migration[5.0]
  def up
    create_table :servicos_vendas do |t|
      t.references :venda, foreign_key: true, null: false
      t.references :servico, foreign_key: true, null: false

      t.timestamps
    end
  end

  def down
    drop_table :servicos_vendas
  end
end
