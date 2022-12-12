class PagesController < ApplicationController
  before_action :set_order_items
  before_action :set_category
  before_action :set_store
  def home
    @products = Product.all.limit(5)
    # @order_item = current_order.order_items.new
  end
  def about
  end
  def search
    puts "#{params[:search]}"
    query = params[:search]
    results = Product.where('product_name LIKE ?', "#{query}%")
    puts params[:filter]
    @products = results

    render 'pages/home'
  end
  def sort_price
    puts "sort_by_price"
    @products  = Product.lower_price
    # redirect_to root_path
    puts @product
    render 'pages/home'
  end
  def high_price
    puts "high_price"
    @products  = Product.high_price
    render 'pages/home'
  end
  def show
    @products = Category.find(params[:id]).products
    render 'pages/home'
  end
  def category_info_show
    @products = Category.find(params[:id]).products
    render 'pages/home'
  end
  def show_product_owner
    @products = Store.find(params[:id]).products
    render 'pages/home'
  end
  def show_store_product
    @store = Store.joins(:users).where(users: { id: @currentUser })
    @products = Store.find(2).products
  end
  def product_of_owner
    @products = Store.find(params[:id]).products
    render 'pages/show_store_product'
  end

  private
  def set_order_items
    @order_item = current_order.order_items.new
  end

  def set_store
    @store = Store.all
  end
end
