Rails.application.routes.draw do
  root to: "home#index"

  devise_for :users,
             :controllers => {
               registrations: "users/registrations",
               confirmations: "users/confirmations",
               sessions: "users/sessions",
               passwords: "users/passwords",
             }, :path_names => {:sign_in => "login", :sign_out => "logout"}

  resources :produtos
  resources :minhas_empresas
  resources :clientes
  resources :empresas do
    put :select
    put :add_admin, :on => :collection, :defaults => {:format => "js"}
    put :add_membro, :on => :collection, :defaults => {:format => "js"}
    delete :remove_membro, :on => :collection, :defaults => {:format => "js"}
  end
  resources :administradores do
    delete :remover
  end
end
