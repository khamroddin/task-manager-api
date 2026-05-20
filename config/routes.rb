Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/home', to: 'home#index'

      post '/signup', to: 'auth#signup'
      post '/login', to: 'auth#login'

      get '/profile', to: 'users#profile'

      resources :tasks#, only: [:index, :create]


    end
  end
end


