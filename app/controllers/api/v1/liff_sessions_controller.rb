class Api::V1::LiffSessionsController < ApplicationController
require 'net/http'

  def create
    uri = URI.parse('https://api.line.me/oauth2/v2.1/verify')
    request = Net::HTTP::Post.new(uri)
    request.content_type = 'application/x-www-form-urlencoded'
    request.set_form_data(
      'id_token' => liff_session_params[:id_token],
      'client_id' => ENV['LINE_CLIENT_ID']
    )
    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end

    user_id = JSON.parse(response.body)['sub']
    auth = Authentication.find_by(uid: user_id)

    if auth
      @resource = auth.user
      @token = @resource.create_token
      @resource.save
      render json: {
        success: true,
        data: @resource,
      }, status: 200
    else
      render json: {
        success: false,
        data: {
          errors: ['認証情報が違います。']
        }
      }, status: 401
    end
  end

  private

  def liff_session_params
    params.permit(:id_token)
  end
end
