Rails.application.routes.draw do

  resources :customers do
    resources :locations, only: [:index, :new, :create]
    resources :addresses, only: [:index, :new, :create]
  end

  resources :locations, only: [:show, :edit, :update, :destroy] do
    resources :addresses, only: [:index, :new, :create]
  end

  resources :addresses, only: [:show, :edit, :update, :destroy]

#####

  resources :switches do
    resources :slots, only: [:index, :new, :create]
    resources :ports, only: [:index, :new, :create]
  end

  resources :slots, only: [:show, :edit, :update, :destroy] do
    resources :ports, only: [:index, :new, :create]
  end

  resources :ports, only: [:show, :edit, :update, :destroy]

  root 'static_pages#home'
end
