class RemoveUserInCliente < ActiveRecord::Migration[5.0]
  def change
    remove_column :clientes, :user_id
  end
end
