Rails.application.routes.draw do
  get 'carts/show'
  # get 'users/index' ,as:'all_users'
  # get 'users/new' ,as:'new_user'
  # get 'users/show/:id' ,as:'show_user_admin'
  # put 'users/edit' ,as:'edit_user_admin'
  # get 'users/new' ,as:'new_user_admin'
  # delete 'users/destroy/:id' ,as:'destroy_users_admin'
  # delete 'users/:id', to: 'users#destroy' ,as:'destroy_users_admin'
  # ,controllers: { registrations: "users/registrations" }
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


  devise_scope :user do
    get "/new_customer" => "users/registrations#new_customer"
    post "/new_customer" => "users/registrations#create"
  end
end
