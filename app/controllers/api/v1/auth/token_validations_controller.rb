class Api::V1::Auth::TokenValidationsController < DeviseTokenAuth::TokenValidationsController
  before_action :authenticate_api_v1_user!, only: [:destroy]

  protected

  # lineとの連携情報を入れる
  def render_validate_token_success
    render json: {
      success: true,
      data: @resource.as_json(methods: :line_linked?)
    }
  end
end
