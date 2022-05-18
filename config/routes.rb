Rails.application.routes.draw do
  devise_for :users
  root to: 'cars#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cars, only: %i[index show new create update] do
    resources :bookings, only: %i[create]
  end
  resources :bookings, only: %i[update index]
end
