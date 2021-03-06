Rails.application.routes.draw do
  resources :users
  namespace :api do
    namespace :v1 do
      post '/login', to: "authentication#create"
      post '/authenticate', to: "authentication#show"
      post '/search', to: "search#show"
      resources :users, only: [:show, :create]
      resources :image_labels, only: [:show, :create]
      resources :images, only: [:show, :create, :destroy]
      resources :labels, only: [:show, :create]
    end
  end
end