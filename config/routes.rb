Rails.application.routes.draw do

  root 'users#index'

  resources :users, only: [:create]

  get 'update_users', to: 'users#update_users'

  post 'delete_user', to: 'users#delete_user'

  post 'destroy_user', to: 'users#destroy_user'

  get 'new_token', to: 'users#new_token'

  post 'new_token', to: 'users#send_token'
end


