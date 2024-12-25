Rails.application.routes.draw do
  resources :orders, only: [ :index, :show, :create, :update ] do
    get "confirm", as: "confirm"
  end

  resources :stores do
    post "remove_spotlight", as: "remove_spotlight"
    resources :products do
      post "archive", as: "archive"
    end
  end

  devise_for :users
  devise_for :store_admins

  namespace :store_admins do
    resources :orders
  end

  resources :user  do
    resource :cart, only: [ :show, :edit, :update, :destroy ] do
      get "checkout"
      resources :cart_items, only: :update, as: "items"
    end
  end

  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check
end
