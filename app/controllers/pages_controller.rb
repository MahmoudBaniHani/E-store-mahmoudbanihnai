class PagesController < ApplicationController
  before_action :set_order_items
  before_action :set_category
  before_action :set_store
  before_action :authenticate_user!
  before_action :only => [:upload] do
    redirect_to new_user_session_path unless current_user.admin?
  end
  def home
    # @products = Product.paginate(:page =>params[:page],per_page: 12)
  end
  def about
  end
  def dashboard_admin
  end
  def upload
  end
  def search
    @products = Product.where('product_name LIKE ?', "#{params[:search]}%").paginate(:page =>params[:page],per_page: 12)
    render 'pages/home'
  end
  def sort_price
    @products  = Product.lower_price.paginate(:page =>params[:page],per_page: 12)
    render 'pages/home'
  end
  def high_price
    @products  = Product.high_price.paginate(:page =>params[:page],per_page: 12)
    render 'pages/home'
  end
  def show
  end
  def category_info_show
    @products = Category.find(params[:id]).products.paginate(:page =>params[:page],per_page: 12)
    render 'pages/home'
  end
  def show_product_owner
    @products = Store.find(params[:id]).products.paginate(:page =>params[:page],per_page: 12)
    render 'pages/home'
  end
  def show_store_product
    @products = Product.all.where(:user_id => current_user.id)
    render 'products/index'
  end
  def product_of_owner
    @products = Store.find(params[:id]).products
    render 'pages/show_store_product'
  end
  def purchase_order
    # @order_by_item = Order.all.where(:status => 1)
    # @stores = Store.joins(:users).where(users: { id: current_user.id })
      respond_to do |format|
        format.html
        format.json { render json: OrderItemDatatable.new(params, {current_user: current_user}) }
      end
  end
  private
  def set_order_items
    @order_item = current_order.order_items.new
  end

  def set_store
    @store = Store.all
  end
end
