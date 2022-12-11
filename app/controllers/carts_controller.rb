class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items
  end
  def check_out
    puts "check out"
    if user_signed_in?
      if current_user.customer?
        @order = current_order
        @order.status = 1
        @order.user_id = current_user.id
        @order.save
        reset_session
        redirect_to root_path
      end

    else
      redirect_to new_user_session_path
    end

  end
end
