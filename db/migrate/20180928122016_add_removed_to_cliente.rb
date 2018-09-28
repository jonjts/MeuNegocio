class AddRemovedToCliente < ActiveRecord::Migration[5.0]
  def up
    add_column :clientes, :removido_em, :timestamp
  end

  def down
    remove_column :clientes, :removido_em
  end
end
