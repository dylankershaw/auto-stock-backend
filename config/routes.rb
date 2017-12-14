Rails.application.routes.draw do
  resources :users
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :create]
      resources :image_labels, only: [:show, :create]
      resources :images, only: [:show, :create]
      resources :labels, only: [:show, :create]
    end
  end
end