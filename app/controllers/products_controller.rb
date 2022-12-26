class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :only => [:new, :edit,:index,:show,:create,:destroy,:update] do
    redirect_to new_user_session_path unless current_user.admin? || current_user.owner?
  end
  before_action :set_category, only: %i[ update create ]
  before_action :set_user, only: %i[ create index]

  # GET /products or /products.json
  def index
    # if current_user.admin?
    #     @products = Product.all
    # elsif current_user.owner?
    #   @products = Product.all.where(:user_id => current_user.id)
    # elsif current_user.customer?
    #   @products = Product.all
    # end
    case  current_user.role
      when 'admin'
        # @products = Product.all
        @products = Product.all.paginate(:page =>params[:page],per_page: 12)
      when 'owner'
        @products = Product.paginate(:page =>params[:page],per_page: 12).where(:user_id => current_user.id)
      when 'customer'
        @products = Product.all.paginate(:page =>params[:page],per_page: 12)
      end
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    @product.user  = @user
    respond_to do |format|
      if @product.save
        @product.categories << @category

        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        @product.categories.clear
        @product.categories << @category
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def import
    Product.import(params[:file])
    redirect_to products_path ,notice: "Product was successfully imported"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:product_name, :description, :price, :production_date, :exp_date, :quantity, :image, :store_id)
  end

  def set_category
    @category_id = params.require(:product).permit(:category_id)
    @category = Category.find(@category_id[:category_id].to_i)
  end
  def set_user
    @currentUser = current_user.id
    @user = User.find(@currentUser)
  end
end
