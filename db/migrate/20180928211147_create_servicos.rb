class CreateServicos < ActiveRecord::Migration[5.0]
  def up
    create_table :servicos do |t|
      t.references :empresa, foreign_key: true, null: false
      t.string :nome, :null => false
      t.decimal :valor_venda, :precision => 15, :scale => 2, null: false
      t.boolean :situacao, null: false, default: true
      t.text :descricao
      t.timestamp :removido_em

      t.timestamps
    end
  end

  def down
    drop_table :servicos
  end
end
