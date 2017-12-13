Rails.application.routes.draw do
  resources :users
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :update]
      post '/login', to: "sessions#create"
    end
  end
end