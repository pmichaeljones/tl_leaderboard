Rails.application.routes.draw do

  root 'users#index'

  resources :users, only: [:create]

  get 'update_users', to: 'users#update_users'

end


