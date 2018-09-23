class RenameColumnInEmpresas < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :empresas, :criado_por_id, :criado_por
  end

  def self.down
    rename_column :empresas, :criado_por, :criado_por_id
  end
end
