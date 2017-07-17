Rails.application.routes.draw do

  root 'books#index'

  match '/signup', to: 'users#new',          via: 'get'
  match '/signup', to: 'users#create',       via: 'post'
  match '/login',  to: 'sessions#new',       via: 'get'
  match '/login',  to: 'sessions#create',    via: 'post'
  match '/logout', to: 'sessions#destroy',   via: 'delete'

  resources :comments

  resources :users do
    resources :comments
  end

  resources :books do
    resources :comments
  end

end
