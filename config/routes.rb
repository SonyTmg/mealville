Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/dashboard', to: 'dashboard#general'
  patch '/become-host', to: 'users#become_host'

  namespace :host do
    get '/dashboard', to: 'dashboard#index'

    resources :events do
      resources :bookings, only: [] do
        resources :reviews, only: %i[new create index]
      end
    end
  end

  resources :events do
    resources :bookings, only: [] do
      resources :reviews, only: %i[new create index]
    end
  end

  resources :reviews, only: %i[show]
end
