Rails.application.routes.draw do
  resources :slots
  resources :switches
  root 'static_pages#home'
end
