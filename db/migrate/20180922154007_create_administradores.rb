class CreateAdministradores < ActiveRecord::Migration[5.0]
  def up
    create_table :administradores do |t|
      t.references :user, foreign_key: true, :null => false
      t.references :empresa, foreign_key: true, :null => false

      t.timestamps
    end
  end

  def down
    drop_table :administradores
  end
end
