class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  # name属性追加のためオーバーライド

  private

  def sign_up_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
