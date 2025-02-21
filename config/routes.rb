Rails.application.routes.draw do
  devise_for :users
  devise_for :store_admins
  Rails.application.routes.draw do
    if Rails.env.development?
      mount Lookbook::Engine, at: "/lookbook"
    end
  end

  # TODO: change to a order_confirmation controller
  resources :orders, only: [ :index, :show, :create, :update ] do
    get "confirm", as: "confirm"
  end

  resources :stores, only: [ :index, :show ] do
    resources :store_images, only: [ :show ]
    resources :store_reviews, only: [ :index, :new, :create ]
    resources :products, only: [ :index, :show ] do
      # TODO: create new controller for creating/deleting product_images to keep it RESTful
      # TODO: move to store_admin namespace
      delete "remove_image", as: "remove_image"
      # TODO: move to store_admin namespace
      resources :product_images
      resources :product_reviews, as: "reviews"
    end
  end

  resources :store_admin do
    resources :stores, controller: "store_admin/stores", except: [ :index ] do
      resources :orders
      resources :products, controller: "store_admin/products", except: [ :destroy ]
      resources :store_images, controller: "store_admin/store_images", except: [ :index, :update ]
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

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check
end
