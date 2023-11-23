class Api::V1::LineIntegrationController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def create
    user = User.find_by(email: user_params[:email])
    link_token = user_params[:link_token]

    if user&.valid_password?(user_params[:password])
      nonce = user.create_nonce
      url = "https://access.line.me/dialog/bot/accountLink?linkToken=#{link_token}&nonce=#{nonce.val}"
      redirect_to url
    else
      render json: {
        success: true,
        data: {
          errors: ['メールアドレスまたはパスワードが間違っています']
        }
      }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password, :link_token)
  end
end
