class PagesController < ApplicationController
  def home
    # @products = Product.all.limit(10)
    @products = Product.all
    @order_item = current_order.order_items.new
  end
  def about

  end

  def show
    @product = Product.find(params[:id])
  end
end
