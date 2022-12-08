class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
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
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    end
  end
  def update
    respond_to do |format|
      if @user.update(user_params)
        redirect_to root_path
      end
    end
  end
  def destroy
    @user.destroy
    redirect_to root_path
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:email , :password,:role,:first_name,:last_name)
  end
end
