class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit ,:update ,:destroy ]
  before_action :authenticate_user!
  before_action :only => [:new, :edit,:index,:show,:create,:destroy,:update] do
    redirect_to new_user_session_path unless current_user.admin? || current_user.owner?
  end

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: "User was successfully created." }
        format.json { render :index, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @user.destroy
    redirect_to users_path
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:email ,:password,:role,:first_name,:last_name)
  end
end
