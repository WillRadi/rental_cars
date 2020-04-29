Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :manufacturers
  resources :subsidiaries, only: [:index, :show, :new, :create, :edit, :update]
  resources :car_categories, only: [:index, :new, :create, :show]
  resources :car_models, only: [:index, :new, :create, :show]
  resources :customers, only: [:index, :new, :create, :show] do
    get 'search', on: :collection
  end
  resources :cars, only: [:index, :new, :create, :show]
  resources :rentals, only: [:index, :new, :create] do
    get 'search', on: :collection
  end
end
