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

  resources :stores, only: [ :index, :show ] do
    resources :store_reviews, as: "reviews"
    # TODO: create new controller for creating/deleting spotlight to keep it RESTful
    # TODO: move to store_admin namespace
    delete "remove_spotlight", as: "remove_spotlight"
    # TODO: move to store_admin namespace
    resources :products, only: [ :index, :show ] do
      # TODO: create new controller for creating/deleting product_images to keep it RESTful
      # TODO: move to store_admin namespace
      delete "remove_image", as: "remove_image"
      resources :product_images
      # TODO: move to store_admin namespace
      resources :product_reviews, as: "reviews"
    end
  end

  resources :store_admin do
    resources :orders
    resources :stores, controller: "store_admin/stores" do
      resources :products, controller: "store_admin/products"
    end
  end

  resources :user  do
    resource :cart, only: [ :show, :edit, :update, :destroy ] do
      get "checkout"
      resources :cart_items, only: :update, as: "items"
    end
  end

  resources :search, only: :index

  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check
end
