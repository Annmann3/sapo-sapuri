class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
end
