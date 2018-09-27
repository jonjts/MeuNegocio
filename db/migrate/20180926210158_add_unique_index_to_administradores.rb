class AddUniqueIndexToAdministradores < ActiveRecord::Migration[5.0]
  def change
    add_index :administradores, [:user_id, :empresa_id], unique: true
  end
end
