Appstarter::Application.routes.draw do
  delete "logout"  => "sessions#destroy",   as: "logout"
  get "login"   => "sessions#new",          as: "login"
  get "signup"  => "users#new",             as: "signup"

  resources :pictures
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :events, only: [:index, :show]
  # static pages
  get 'about' => "pages#about", as: :about
  get 'tos' => "pages#tos", as: :tos
  get 'privacy' => "pages#privacy", as: :privacy
  get 'aup' => "pages#aup", as: :aup
  get 'dmca' => "pages#dmca", as: :dmca
  get "contact" => "pages#contact", :as =>"contact"
  
  # settings page
  get 'settings/account'
  get 'settings/password'
  get 'settings/profile'
  
  root :to => "pages#home"
end
