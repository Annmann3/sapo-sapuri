Rails.application.config.middleware.use OmniAuth::Builder do
  require 'omniauth/strategies/line'
  provider :line, ENV['LINE_CLIENT_ID'], ENV['LINE_CLIENT_SECRET']
end
