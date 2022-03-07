Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.
  resources :events do
    resources :bookings
  end

  resources :bookings, only: [] do
    resources :reviews, only: %i[new create index]
  end

  resources :reviews, only: %i[show]
end
