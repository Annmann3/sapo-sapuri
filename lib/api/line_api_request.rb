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
      request = Net::HTTP::Post.new(uri)
      request['Authorization'] = "Bearer #{ENV.fetch('LINE_MESSAGING_API_TOKEN', nil)}"
      Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(request)
      end
    end

    def push_integration_message
      link_token = create_link_token
      uri = URI.parse('https://api.line.me/v2/bot/message/push')
      origin = ENV.fetch('RAILS_URL_ORIGIN', nil)
      integration_uri = "#{origin}/line-integration?linkToken=#{link_token}"

      request = Net::HTTP::Post.new(uri)
      request.content_type = 'application/json'
      request['Authorization'] = "Bearer #{ENV.fetch('LINE_MESSAGING_API_TOKEN', nil)}"
      request.body = JSON.dump({
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
      Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(request)
      end
    end

    def delete_rich_menu
      uri = URI.parse("https://api.line.me/v2/bot/user/#{@user_id}/richmenu")
      request = Net::HTTP::Delete.new(uri)
      request['Authorization'] = "Bearer #{ENV.fetch('LINE_MESSAGING_API_TOKEN', nil)}"
      Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(request)
      end
    end

    private

    def create_link_token
      uri = URI.parse("https://api.line.me/v2/bot/user/#{@user_id}/linkToken")
      request = Net::HTTP::Post.new(uri)
      request['Authorization'] = "Bearer #{ENV.fetch('LINE_MESSAGING_API_TOKEN', nil)}"
      response = Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(request)
      end

      JSON(response.body)['linkToken']
    end
  end
end
