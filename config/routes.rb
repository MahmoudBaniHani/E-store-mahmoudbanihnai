Rails.application.routes.draw do
  get 'carts/show'
  devise_for :users
  post 'create_user' => 'users#create', as: :create_user
  resources :users
  resources :orders
  resources :products
  resources :stores
  resources :order_items

  root 'pages#home'
  get 'pages/about'
  resources :categories
  resources :pages
  post 'carts/check_out' ,to: 'carts#check_out', as: 'check_out'
  get 'search', to: 'pages#search'
  get 'sort_by_price', to: 'pages#sort_price'
  get 'sort_high_price', to: 'pages#high_price'


  get 'show_product_owner',to: 'pages#show_product_owner'
  get 'show_product_in_owner',to: 'pages#show_store_product'
  get 'product_of_owner',to: 'pages#product_of_owner'
  get 'show_cat_info/:id',as: 'category_info' ,to:'pages#category_info_show'

  get 'purchase_order',to:'pages#purchase_order'

  devise_scope :user do
    get "/new_customer" => "users/registrations#new_customer"
    post "/new_customer" => "users/registrations#create"
  end
end
