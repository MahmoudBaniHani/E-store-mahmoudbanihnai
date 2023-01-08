require 'sidekiq/web'
Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  # mount Sidekiq::Web =>'/sidekiq'
  root 'pages#home'
  devise_for :users
  devise_scope :user do
    get "/new_customer" => "users/registrations#new_customer"
    post "/new_customer" => "users/registrations#create"
  end
  resources :users
  resources :orders
  resources :products do
    collection {
      post :import
    }
  end
  resources :stores
  resources :order_items
  resources :categories
  resources :pages

  get 'upload_product',to:'pages#upload'
  get 'Dashboard',to:'pages#dashboard_admin'

  get 'pages/about' ,to: 'pages#about'
  post 'carts/check_out' ,to: 'carts#check_out', as: 'check_out'
  get 'carts/show'
  get 'search', to: 'pages#search'
  get 'sort_by_price', to: 'pages#sort_price'
  get 'sort_high_price', to: 'pages#high_price'
  get 'show_product_owner',to: 'pages#show_product_owner'
  get 'show_product_in_owner',to: 'pages#show_store_product'
  post 'create_user' => 'users#create', as: :create_user
  get 'product_of_owner',to: 'pages#product_of_owner'
  get 'show_cat_info/:id',as: 'category_info' ,to:'pages#category_info_show'
  get 'purchase_order',to:'pages#purchase_order'


end
