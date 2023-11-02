require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Line < OmniAuth::Strategies::OAuth2
      option :name, 'line'
      option :scope, 'openid profile'

      option :client_options, {
        site: 'https://access.line.me',
        authorize_url: '/oauth2/v2.1/authorize',
        token_url: '/oauth2/v2.1/token'
      }

      # host changed
      def callback_phase
        options[:client_options][:site] = 'https://api.line.me'
        super
      end

      def callback_url
        options[:callback_url] || (full_host + script_name + callback_path)
      end

      uid { raw_info['sub'] }

      info do
        {
          name: raw_info['name'],
          image: raw_info['picture'],
          description: raw_info['statusMessage'],
          nonce: raw_info['nonce']
        }
      end

      def authorize_params
        super.tap do |params|
          params[:nonce] = SecureRandom.uuid
          session['omniauth.nonce'] = params[:nonce]
          params[:bot_prompt] = 'aggressive'
        end
      end

      def raw_info
        @raw_info ||= client.request(:post, 'https://api.line.me/oauth2/v2.1/verify',
                                     {
                                       body: {
                                         id_token: access_token['id_token'],
                                         client_id: options.client_id,
                                         nonce: session['omniauth.nonce']
                                       }
                                     }).parsed
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end
    end
  end
end
