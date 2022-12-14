class StoresController < ApplicationController
  before_action :set_store, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :only => [:new, :edit,:index,:show,:create,:destroy,:update] do
    redirect_to new_user_session_path unless current_user.admin? or current_user.owner?
  end
  before_action :set_user, only: %i[ create index update]


  # GET /stores or /stores.json
  def index
    if current_user.admin?
      @stores = Store.all
    else
      @stores = Store.joins(:users).where(users: { id: @currentUser })
    end
  end

  # GET /stores/1 or /stores/1.json
  def show
  end

  # GET /stores/new
  def new
    @status_array = Store.statuses.keys.map { |status| [status.titleize, status] }
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores or /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        @store.users.clear
        @store.users << @user
        format.html { redirect_to store_url(@store), notice: "Store was successfully created." }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1 or /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        @store.users << @user
        format.html { redirect_to store_url(@store), notice: "Store was successfully updated." }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1 or /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url, notice: "Store was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_store
    @store = Store.find(params[:id])
  end
  def set_user
    @currentUser = current_user.id
    @user = User.find(@currentUser)
  end
  # Only allow a list of trusted parameters through.
  def store_params
    params.require(:store).permit(:store_name, :phone, :status)
  end
end
