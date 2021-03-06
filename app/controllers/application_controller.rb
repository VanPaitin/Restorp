class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json
  before_action :configure_permitted_parameters, if: :devise_controller?

  def documentation
    redirect_to ENV['API_DOCUMENTATION']
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
