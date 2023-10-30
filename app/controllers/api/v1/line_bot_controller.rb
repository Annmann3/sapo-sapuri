class Api::V1::LineBotController < ApplicationController
  require 'line/bot'
  require 'net/http'

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_MESSAGING_API_SECRET']
      config.channel_token = ENV['LINE_MESSAGING_API_TOKEN']
    end
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)
    events.each do |event|
      user_id = event['source']['userId']
      auth = Authentication.find_by(provider: 'line', uid: user_id)

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if event.message['text'] == 'LINE連携'
            if auth
              message = {
                type: 'text',
                text: '連携済みです'
              }
              client.reply_message(event['replyToken'], message)
            else
              message = {
                type: 'text',
                text: "連携を開始します。\nしばらくお待ち下さい。"
              }

              client.reply_message(event['replyToken'], message)
              uri = URI.parse("https://api.line.me/v2/bot/user/#{user_id}/linkToken")
              request = Net::HTTP::Post.new(uri)
              request['Authorization'] = "Bearer #{ENV['LINE_MESSAGING_API_TOKEN']}"
              response = Net::HTTP.start(uri.host, uri.port) do |http|
                http.request(request)
              end

              link_token = JSON(response.body)['linkToken']

              uri = URI.parse('https://api.line.me/v2/bot/message/push')
              origin = 'https://3c09-2001-f71-bec0-2300-2944-eca4-a7fe-2fdc.ngrok-free.app'
              integration_uri = "#{origin}/line-integration?linkToken=#{link_token}"

              request = Net::HTTP::Post.new(uri)
              request.content_type = 'application/json'
              request['Authorization'] = "Bearer #{ENV['LINE_MESSAGING_API_TOKEN']}"
              request.body = JSON.dump({
                to: user_id,
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
              response = Net::HTTP.start(uri.host, uri.port) do |http|
                http.request(request)
              end
            end
          end
          message = {
            type: 'text',
            text: event.message['text']
          }
          client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
          response = client.get_message_content(event.message['id'])
          tf = Tempfile.open('content')
          tf.write(response.body)
        end
      when Line::Bot::Event::AccountLink
        if event.result == 'ok'
          nonce = Nonce.find_by(val: event.nonce)
          user = nonce.user
          user.authentications.create(provider: 'line', uid: event['source']['userId'])
          client.reply_message(event['replyToken'], { type: 'text', text: '連携が完了しました。' })
        else
          client.reply_message(event['replyToken'], { type: 'text', text: '連携に失敗しました。' })
        end
      end
    end

    head :ok
  end
end
