class AddEmpresaToClientes < ActiveRecord::Migration[5.0]
  def change
    add_reference :clientes, :empresa, foreign_key: true, :null => false
  end
end
