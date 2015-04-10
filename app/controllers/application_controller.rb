class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  layout :layout_by_resource
  
  protected
  
  def layout_by_resource
    if devise_controller? && resource_name == :player && ['new', 'create'].include?(action_name)
      'public'
    else
      'application'
    end
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :gender_id,
      :role,
      :password,
      :password_confirmation,
      :current_password
    ) }
    

  end
  
end
