# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180929000638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administradores", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "empresa_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["empresa_id"], name: "index_administradores_on_empresa_id", using: :btree
    t.index ["user_id", "empresa_id"], name: "index_administradores_on_user_id_and_empresa_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_administradores_on_user_id", using: :btree
  end

  create_table "clientes", force: :cascade do |t|
    t.string   "nome"
    t.string   "cpf"
    t.string   "rg"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "empresa_id",  null: false
    t.datetime "removido_em"
    t.index ["empresa_id"], name: "index_clientes_on_empresa_id", using: :btree
  end

  create_table "empresas", force: :cascade do |t|
    t.string   "nome",       null: false
    t.integer  "criado_por", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["criado_por"], name: "index_empresas_on_criado_por", using: :btree
  end

  create_table "enderecos", force: :cascade do |t|
    t.integer  "cliente_id",  null: false
    t.string   "cep"
    t.string   "cidade",      null: false
    t.string   "rua"
    t.string   "bairro"
    t.text     "complemento"
    t.integer  "numero"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["cliente_id"], name: "index_enderecos_on_cliente_id", using: :btree
  end

  create_table "minhas_empresas", force: :cascade do |t|
    t.integer  "empresa_id", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["empresa_id"], name: "index_minhas_empresas_on_empresa_id", using: :btree
    t.index ["user_id", "empresa_id"], name: "index_minhas_empresas_on_user_id_and_empresa_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_minhas_empresas_on_user_id", using: :btree
  end

  create_table "pagamentos_vendas", force: :cascade do |t|
    t.integer  "venda_id",                                null: false
    t.integer  "numero_parcela",                          null: false
    t.decimal  "valor",          precision: 15, scale: 2, null: false
    t.date     "data_pagamento",                          null: false
    t.datetime "pago_em"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["venda_id"], name: "index_pagamentos_vendas_on_venda_id", using: :btree
  end

  create_table "produtos", force: :cascade do |t|
    t.integer  "empresa_id",                                            null: false
    t.string   "nome",                                                  null: false
    t.integer  "quantidade",                                            null: false
    t.decimal  "valor_compra", precision: 15, scale: 2, default: "0.0"
    t.decimal  "valor_venda",  precision: 15, scale: 2,                 null: false
    t.boolean  "situacao",                              default: true,  null: false
    t.text     "descricao"
    t.datetime "removido_em"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.index ["empresa_id"], name: "index_produtos_on_empresa_id", using: :btree
  end

  create_table "produtos_vendas", force: :cascade do |t|
    t.integer  "venda_id",   null: false
    t.integer  "produto_id", null: false
    t.integer  "quantidade", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["produto_id"], name: "index_produtos_vendas_on_produto_id", using: :btree
    t.index ["venda_id"], name: "index_produtos_vendas_on_venda_id", using: :btree
  end

  create_table "servicos", force: :cascade do |t|
    t.integer  "empresa_id",                                          null: false
    t.string   "nome",                                                null: false
    t.decimal  "valor_venda", precision: 15, scale: 2,                null: false
    t.boolean  "situacao",                             default: true, null: false
    t.text     "descricao"
    t.datetime "removido_em"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.index ["empresa_id"], name: "index_servicos_on_empresa_id", using: :btree
  end

  create_table "servicos_vendas", force: :cascade do |t|
    t.integer  "venda_id",   null: false
    t.integer  "servico_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["servico_id"], name: "index_servicos_vendas_on_servico_id", using: :btree
    t.index ["venda_id"], name: "index_servicos_vendas_on_venda_id", using: :btree
  end

  create_table "telefones", force: :cascade do |t|
    t.integer  "cliente_id", null: false
    t.string   "numero",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_telefones_on_cliente_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "vendas", force: :cascade do |t|
    t.integer  "cliente_id",                                              null: false
    t.decimal  "taxa_adicional", precision: 15, scale: 2,                 null: false
    t.text     "descricao"
    t.decimal  "desconto",       precision: 15, scale: 2, default: "0.0", null: false
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.decimal  "entrada",        precision: 15, scale: 2, default: "0.0", null: false
    t.index ["cliente_id"], name: "index_vendas_on_cliente_id", using: :btree
  end

  add_foreign_key "administradores", "empresas"
  add_foreign_key "administradores", "users"
  add_foreign_key "clientes", "empresas"
  add_foreign_key "empresas", "users", column: "criado_por"
  add_foreign_key "enderecos", "clientes"
  add_foreign_key "minhas_empresas", "empresas"
  add_foreign_key "minhas_empresas", "users"
  add_foreign_key "pagamentos_vendas", "vendas"
  add_foreign_key "produtos", "empresas"
  add_foreign_key "produtos_vendas", "produtos"
  add_foreign_key "produtos_vendas", "vendas"
  add_foreign_key "servicos", "empresas"
  add_foreign_key "servicos_vendas", "servicos"
  add_foreign_key "servicos_vendas", "vendas"
  add_foreign_key "telefones", "clientes"
  add_foreign_key "vendas", "clientes"
end
