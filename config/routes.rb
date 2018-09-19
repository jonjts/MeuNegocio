Rails.application.routes.draw do
  root to: "home#index"

  devise_for :users,
             :controllers => {
               registrations: "users/registrations",
               confirmations: "users/confirmations",
               sessions: "users/sessions",
               passwords: "users/passwords",
             }, :path_names => {:sign_in => "login", :sign_out => "logout"}
end
