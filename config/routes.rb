Rails.application.routes.draw do
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
