Rails.application.routes.draw do
  root to: "home#index"

  devise_for :users,
             :controllers => {
               registrations: "users/registrations",
               confirmations: "users/confirmations",
               sessions: "users/sessions",
               passwords: "users/passwords",
             }, :path_names => {:sign_in => "login", :sign_out => "logout"}

  resources :clientes
  resources :empresas do
    put :select
  end
  resources :minhas_empresas
  resources :administradores do
    delete :remover
  end
end
