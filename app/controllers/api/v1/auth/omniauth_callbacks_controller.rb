class Api::V1::Auth::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  def omniauth_success
    # ログイン中の場合,弾く
    if omniauth_params['provider'] == 'email'
      fallback_render 'すでにログイン中です。'
    else
      get_resource_from_auth_hash
      set_token_on_resource
      create_auth_params

      if confirmable_enabled?
        # don't send confirmation email!!!
        @resource.skip_confirmation!
      end

      sign_in(:user, @resource, store: false, bypass: false)

      @resource.save!
      @authentication.update!(user: @resource)

      yield @resource if block_given?

      set_token_in_cookie(@resource, @token) if DeviseTokenAuth.cookie_enabled

      render_data_or_redirect('deliverCredentials', @auth_params.as_json, @resource.as_json)
    end
  end

  def get_resource_from_auth_hash
    # AuthEnticationモデルを介してuserを取得または作成する。
    # SNS連携済みの場合は,userを取得する
    @authentication = Authentication.find_from_auth(auth_hash)
    if @authentication.user
      @resource = @authentication.user
    else
      @resource = @authentication.build_user(
        provider: auth_hash['provider'],
        uid: auth_hash['uid']
      )
      handle_new_resource
    end

    # sync user info with provider, update/generate auth token
    assign_provider_attrs(@resource, auth_hash)

    # assign any additional (whitelisted) attributes
    if assign_whitelisted_params?
      extra_params = whitelisted_params
      @resource.assign_attributes(extra_params) if extra_params
    end

    @resource
  end
end
