Rails.application.routes.draw do
  resources :ports
  resources :slots
  resources :switches
  root 'static_pages#home'
end
