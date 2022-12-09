class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items
  end
  def check_out
    puts "check out"
    @order = current_order
    @order.status = 1
    @order.save
    reset_session
    redirect_to root_path
  end
end
