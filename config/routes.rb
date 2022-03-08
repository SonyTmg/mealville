Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/dashboard', to: 'dashboard#general'
  patch '/become-host', to: 'users#become_host'

  # These routes are isolated for host users, that do not affect general users.
  # These will all fall under a /host route eg:
  # host/dashboard, host/events, host/bookings
  namespace :host do
    get '/dashboard', to: 'dashboard#index'

    resources :events do
      resources :bookings, only: %i[] do
        resources :reviews, only: %i[index show]

        patch '/confirm', to: 'bookings#confirm'
      end
    end
  end

  resources :events do
    resources :bookings, only: %i[create new]
  end

  resources :bookings, only: %i[destroy show index] do
    resources :reviews, only: %i[new create index]
  end

  resources :reviews, only: %i[show]
end
