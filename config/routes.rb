Rails.application.routes.draw do
  get 'carts/show'
  get 'users/index' ,as:'user'
  get 'users/show' ,as:'show_user'
  get 'users/edit' ,as:'edit_user'
  get 'users/new' ,as:'new_user'
  resources :orders
  resources :products
  resources :stores
  resources :order_items
  devise_for :users
  root 'pages#home'
  get 'pages/about'
  resources :categories
  resources :pages
  post 'carts/check_out' ,to: 'carts#check_out', as: 'check_out'
end
