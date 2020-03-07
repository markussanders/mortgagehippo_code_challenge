Rails.application.routes.draw do
  resources :transactions, only: [:index, :show, :create]
  resources :users
  resources :coins
end
