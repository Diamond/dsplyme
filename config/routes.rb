Showoff::Application.routes.draw do

  ### SPECIAL PATHS
  get "logout" => "sessions#destroy", as: "logout"
  get "login"  => "sessions#new", as: "login"
  get "signup" => "users#new", as: "signup"
  
  ### RESOURCES
  resources :projects do
    resources :comments
  end
  resources :users, only: [:new, :create, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]

  # ROOT
  root 'homepage#index'
end
