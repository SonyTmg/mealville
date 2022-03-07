Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/dashboard', to: 'dashboard#general'
  get '/dashboard/host', to: 'dashboard#host'
  patch '/toggle-host', to: 'users#toggle_host'
end
