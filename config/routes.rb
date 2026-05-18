Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/home', to: 'home#index'

      post '/signup', to: 'auth#signup'
    end
  end
end


