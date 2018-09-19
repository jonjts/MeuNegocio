class CreateTelefones < ActiveRecord::Migration[5.0]
  def up
    create_table :telefones do |t|
      t.references :cliente, foreign_key: true, :null => false
      t.string :numero, :null => false

      t.timestamps
    end
  end

  def down
    drop_table :telefones
  end
end
