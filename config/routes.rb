require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  resources :rooms do
    resources :messages
  end

  resources :provisioning_records
  resources :onts
  resources :dhcp_servers do
    resources :shared_networks, only: [:index, :new, :create]
  end

  resources :shared_networks, only: [:show, :edit, :update, :destroy] do
    resources :subnets, only: [:index, :new, :create]
  end

  resources :subnets, only: [:show, :edit, :update, :destroy] do
    resources :pools, only: [:index, :new, :create]
  end

  resources :pools, only: [:show, :edit, :update, :destroy] do
      resources :ips, only: [:index, :new, :create]
  end

  resources :ips, only: [:show, :edit, :update, :destroy]

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
    resources :switch_configs, only: [:index, :new, :create]
  end

  resources :switch_configs, only: [:index, :show, :edit, :update, :destroy]

  resources :slots, only: [:show, :edit, :update, :destroy] do
    resources :ports, only: [:index, :new, :create]
  end

  resources :ports, only: [:index, :show, :edit, :update, :destroy]

  get '/api/ports/ratelimit', to: 'rate_limit_api#show'
  patch '/api/ports/ratelimit', to: 'rate_limit_api#update'

  root 'static_pages#home'
end
