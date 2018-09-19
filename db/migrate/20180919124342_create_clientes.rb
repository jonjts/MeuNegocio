class CreateClientes < ActiveRecord::Migration[5.0]
  def up
    create_table :clientes do |t|
      t.string :nome
      t.string :cpf
      t.string :rg
      t.timestamps
    end
  end

  def down
    drop_table :clientes
  end
end
