Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/dashboard', to: 'dashboard#index'
  patch '/become-host', to: 'users#become_host'

  # These routes are isolated for host users, that do not affect general users.
  # These will all fall under a /host route eg:
  # host/dashboard, host/events, host/bookings
  namespace :host do
    get '/dashboard', to: 'events#index'

    resources :events do
      resources :bookings, only: %i[show] do
        resources :reviews, only: %i[index show]

        patch '/confirm', to: 'bookings#confirm'
      end
    end
  end

  resources :events do
    resources :bookings, only: %i[create new update] do
      patch '/cancel', to: 'bookings#cancel'
    end
  end

  resources :bookings, only: %i[destroy show index] do
    get '/confirm', to: 'bookings#confirm'
    post '/message-host', to: 'bookings#message_host'
    collection do
      get :success
    end
    resources :reviews, only: %i[new create index]
  end

  resources :reviews, only: %i[show]
end
