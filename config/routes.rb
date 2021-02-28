Rails.application.routes.draw do

  resources :ips
  resources :pools
  resources :subnets
  resources :shared_networks
  resources :dhcp_servers
  resources :customers do
    resources :locations, only: [:index, :new, :create]
    resource :address, only: [:new, :create]
  end

  resources :locations, only: [:show, :edit, :update, :destroy] do
    resource :address, only: [:new, :create]
  end

  resources :addresses, only: [:index, :show, :edit, :update, :destroy]
  resources :locations, only: [:index]

#####

  resources :switches do
    resources :slots, only: [:index, :new, :create]
    resources :ports, only: [:index, :new, :create]
  end

  resources :slots, only: [:show, :edit, :update, :destroy] do
    resources :ports, only: [:index, :new, :create]
  end

  resources :ports, only: [:index, :show, :edit, :update, :destroy]

  root 'static_pages#home'
end
