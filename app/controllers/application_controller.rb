class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters , if: :devise_controller?
  include ApplicationHelper
  before_action :set_category
  before_action :set_store



  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up ,keys: [:role, :first_name, :last_name])
  end
  def set_category
    @cat = Category.all
  end
  def set_store
    @store = Store.all
  end

end
