class Api::V1::AuthenticationsController < ApplicationController
  before_action :authenticate_api_v1_user!, only: [:destroy]

  def destroy
    if current_api_v1_user.email
      auth = api_v1_current_user.authentications.find_by(provider: auth_params[:provider])
      auth.destroy!
      api_v1_current_user.update!(image: nil)
      render json: api_v1_current_user
    else
      render_error_message('メールアドレスとパスワードを設定してから連携を解除してください')
    end
  end

  private

  def auth_params
    params.permit(:provider)
  end
end
