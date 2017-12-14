Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :users
  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
end