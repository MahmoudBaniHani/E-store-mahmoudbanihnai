class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters , if: :devise_controller?
  include ApplicationHelper


  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up ,keys: [:role, :first_name, :last_name])
  end
end
