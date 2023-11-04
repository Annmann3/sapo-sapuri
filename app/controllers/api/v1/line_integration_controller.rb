class Api::V1::LineIntegrationController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]


  def create
    user = User.find_by(email: user_params[:email])
    link_token = user_params[:link_token]

    if user && user.valid_password?(user_params[:password])
      nonce = user.create_nonce
      url = "https://access.line.me/dialog/bot/accountLink?linkToken=#{link_token}&nonce=#{nonce.val}"
      redirect_to url
    else
      render json: {
        success: true,
        data: {
          errors: ['メールアドレスまたはパスワードが間違っています']
        }
      }, status: 401
    end
  end

  def destroy
    unless api_v1_current_user.provider == 'email'
      render json: {
        success: false,
        data: {
          errors: ['メールアドレスとパスワードを設定して連携を解除するかアカウントを削除してください']
        }
      }, status: 401
      return
    end

    auth = api_v1_current_user.authentications.find_by(provider: 'line')
    auth.destroy!
    api_v1_current_user.update!(image: nil)
    render json: {
      success: true,
      data: {
        data: {
          errros: ['連携を解除しました']
        }
      }, status: 200
    }
    return
  end

  private

  def user_params
    params.permit(:email, :password, :link_token)
  end
end
