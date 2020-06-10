Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
      resources :apartments, only: [:index, :show]
      resources :properties, only: [:index, :show]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#show'
      delete '/profile', to: 'users#destroy'
      patch '/profile', to: 'users#update'


    end
  end  
end
