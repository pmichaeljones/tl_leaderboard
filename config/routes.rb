Rails.application.routes.draw do

  root 'ui#index'

  get 'ui(/:action)', controller: 'ui'

end


