class PagesController < ApplicationController
  before_action :set_order_items

  def home
    @products = Product.all
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
    @product = Product.find(params[:id])
  end

  private
  def set_order_items
    @order_item = current_order.order_items.new
  end
end
