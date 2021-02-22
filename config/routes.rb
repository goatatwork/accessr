Rails.application.routes.draw do
  resources :switches
  root 'static_pages#home'
end
