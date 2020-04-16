Rails.application.routes.draw do
  root 'home#index'

  resources :manufacturers
  resources :subsidiaries, only: [:index, :show, :new, :create, :edit, :update]
  resources :car_categories, only: [:index, :new, :create, :show]
  resources :car_models, only: [:index, :new, :create, :show]
  resources :rentals, only: [:index]
end
