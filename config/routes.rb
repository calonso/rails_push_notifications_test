Rails.application.routes.draw do

  resources :apple, only: [:index, :create]
  resources :android, only: [:index, :create]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#index'
end
