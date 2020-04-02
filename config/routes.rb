Rails.application.routes.draw do
  root 'home#index'

  resources :manufacturers, only: [:index, :show]
end
