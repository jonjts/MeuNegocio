class CreateEnderecos < ActiveRecord::Migration[5.0]
  def up
    create_table :enderecos do |t|
      t.references :cliente, foreign_key: true, :null => false
      t.string :cep
      t.string :cidade, :null => false
      t.string :rua
      t.string :bairro
      t.text :complemento
      t.integer :numero

      t.timestamps
    end
  end

  def down
    drop_table :enderecos
  end
end
