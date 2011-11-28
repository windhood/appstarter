Appstarter::Application.routes.draw do
  root :to => "pages#home"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :users
  resources :sessions
  
  get "about" => "pages#about", :as =>"about"
  #match '/about',   :to => 'pages#about'
  
end
