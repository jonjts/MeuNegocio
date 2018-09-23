class CreateMinhasEmpresas < ActiveRecord::Migration[5.0]
  def up
    create_table :minhas_empresas do |t|
      t.references :empresa, foreign_key: true, :null => false
      t.references :user, foreign_key: true, :null => false

      t.timestamps
    end
  end

  def down
    drop_table :minhas_empresas
  end
end
