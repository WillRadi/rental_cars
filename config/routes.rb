Rails.application.routes.draw do
  root 'home#index'

  resources :manufacturers
  resources :subsidiaries, only: [:index]
end
