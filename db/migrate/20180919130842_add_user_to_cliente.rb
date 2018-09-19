class AddUserToCliente < ActiveRecord::Migration[5.0]
  def change
    add_reference :clientes, :user, foreign_key: true, :null => false
  end
end
