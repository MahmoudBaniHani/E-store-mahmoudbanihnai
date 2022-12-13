class OrderItemsController < ApplicationController
  before_action :set_order
  def create
    puts "add in carts",params[:order_item]
    puts "order id is : #{session[:order_id].to_i}"
    @order = OrderItem.where("product_id = ? AND order_id = ?", params[:order_item][:product_id],session[:order_id].to_i).first
    if @order
      puts "order is  not Empty"
      @order.update(quantity: @order.quantity + params[:order_item][:quantity].to_i)
      @order.save
    else
      @order = current_order
      puts "order is is :#{current_order[:order_id].to_i}"
      @order.order_items.new(order_params) do
        @order.status = 0
      end
      @order.save
      session[:order_id] = @order.id
    end
    redirect_to root_path
  end

  def update
    @order_item = @order.order_items.find(params[:id])
    @order_item.update(:quantity=>params[:order_item][:quantity])
    @order_items = current_order.order_items
    respond_to root_path
  end

  def destroy
    puts "order id destroy",params[:id]
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    redirect_to carts_show_path
  end
  private
  def order_params
    params.require(:order_item).permit(:product_id,:quantity)
  end
  def set_order
    @order = current_order
  end

end
