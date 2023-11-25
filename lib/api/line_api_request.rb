module Api
  require 'line/bot'
  require 'net/http'

  class LineApiRequest
    def initialize(line_user_id)
      @user_id = line_user_id
    end

    def change_linked_richmenu
      uri = URI.parse("https://api.line.me/v2/bot/user/#{@user_id}/richmenu/#{ENV.fetch(
        'LINE_MESSAGING_API_RICHMENU_ID', nil
      )}")
      post_request(uri)
    end

    def push_integration_message
      link_token = create_link_token
      uri = URI.parse('https://api.line.me/v2/bot/message/push')
      origin = ENV.fetch('RAILS_URL_ORIGIN', nil)
      integration_uri = "#{origin}/line-integration?linkToken=#{link_token}"

      body = JSON.dump({
                         to: @user_id,
                         messages: [{
                           type: 'text',
                           text: '連携ボタンを押してください。',
                           quickReply: {
                             items: [
                               {
                                 type: 'action',
                                 action: {
                                   type: 'uri',
                                   label: '連携する',
                                   uri: integration_uri
                                 }
                               }
                             ]
                           }
                         }]
                       })
      post_request(uri, body)
    end

    def delete_rich_menu
      uri = URI.parse("https://api.line.me/v2/bot/user/#{@user_id}/richmenu")
      delete_request(uri)
    end

    private

    def post_request(uri, body = nil)
      http_request(uri, Net::HTTP::Post, body)
    end

    def delete_request(uri)
      http_request(uri, Net::HTTP::Delete)
    end

    def http_request(uri, request_class, body = nil)
      request = request_class.new(uri)
      request['Authorization'] = "Bearer #{ENV.fetch('LINE_MESSAGING_API_TOKEN', nil)}"
      request.content_type = 'application/json'
      request.body = body if body
      Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(request)
      end
    end

    def create_link_token
      uri = URI.parse("https://api.line.me/v2/bot/user/#{@user_id}/linkToken")
      response = post_request(uri)
      JSON(response.body)['linkToken']
    end
  end
end
