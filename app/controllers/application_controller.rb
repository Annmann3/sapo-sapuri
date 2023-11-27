class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  protected

  # deviseのストロングパラメーター追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name provider uid])
  end

  def render_error(resource, status = :unauthorized)
    render json: {
      success: false,
      errors: resource.errors.full_messages
    }, status:
  end

  def render_error_message(message, status = :unauthorized)
    render json: {
      success: false,
      errors: message
    }, status:
  end

  def render_success(resource, status = :ok)
    render json: {
      success: true,
      data: resource
    }, status:
  end
end
