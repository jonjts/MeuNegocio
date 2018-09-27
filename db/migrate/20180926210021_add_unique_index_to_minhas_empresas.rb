class AddUniqueIndexToMinhasEmpresas < ActiveRecord::Migration[5.0]
  def up
    add_index :minhas_empresas, [:user_id, :empresa_id], unique: true
  end

  def down
    drop_index :minhas_empresas, [:user_id, :empresa_id]
  end
end
