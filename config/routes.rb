Rails.application.routes.draw do

  devise_for :users

  root to: 'application#index'

  resources :games do
    collection do
      get :search, to: 'games#search', as: :search
      get "new_from_gb/:game", to: 'games#new_from_gb', as: :new_from_gb
    end
  end

  resources :users
  resources :wishlists do
    collection do
      get "new_from_gb/:game", to: 'wishlists#new_from_gb', as: :new_from_gb
    end
  end

  resources :queries
end
