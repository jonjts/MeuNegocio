class CreateEmpresa < ActiveRecord::Migration[5.0]
  def up
    create_table :empresas do |t|
      t.string :nome, :null => false
      t.references :criado_por, foreign_key: {to_table: :users}, :null => false, index: true

      t.timestamps
    end
  end

  def down
    drop_table :empresas
  end
end
