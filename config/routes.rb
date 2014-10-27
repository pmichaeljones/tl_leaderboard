Rails.application.routes.draw do

  root 'users#index'

  resources :users, only: [:create]

  get 'update_users', to: 'users#update_users'

  post 'delete_user', to: 'users#delete_user'

  post 'destroy_user', to: 'users#destroy_user'
end


