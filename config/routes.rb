Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :events do
    resources :bookings, only: %i[create]
  end

  resources :bookings, only: %i[destroy show index] do
    resources :reviews, only: %i[new create index]
  end

  resources :reviews, only: %i[show]

end
