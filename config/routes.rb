Rails.application.routes.draw do
  devise_for :users
  devise_for :store_admins
  Rails.application.routes.draw do
    if Rails.env.development?
      mount Lookbook::Engine, at: "/lookbook"
    end
  end

  resources :orders, only: [ :index, :show, :create, :update ] do
    get "confirm", as: "confirm"
  end

  resources :stores do
    resources :store_reviews, as: "reviews"
    delete "remove_spotlight", as: "remove_spotlight"
    resources :products do
      delete "remove_image", as: "remove_image"
      resources :product_images
      resources :product_reviews, as: "reviews"
    end
  end

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
  get "products", to: "pages#products"
  resources :search, only: :index
  # get "product_search", to: "search#product_search", as: "search"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check
end
