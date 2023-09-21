class Api::V1::AuthenticationsController < ApplicationController
  before_action :authenticate_user!, only: %w[create destroy]

  def create
    @authentication = current_api_v1_user.authentications.build(auth_params)
    if @authentication.save
      render json: @authentication
    else
      render json: @authentication.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @authentication = current_api_v1_user.authentications.find(params[:id])
    @authentication.destroy
    head :no_content
  end

  private

  def auth_params
    params.require(:authentication).permit(:provider, :uid)
  end
end
