class Api::V1::LineBotController < ApplicationController
  require 'line/bot'

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch('LINE_MESSAGING_API_SECRET', nil)
      config.channel_token = ENV.fetch('LINE_MESSAGING_API_TOKEN', nil)
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
      @line_api = LineApiRequest.new(event['source']['userId'])
      auth = Authentication.find_by(provider: 'line', uid: user_id)

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          case event.message['text']
          when 'LINE連携'
            if auth
              message = {
                type: 'text',
                text: '連携済みです'
              }
              # ユーザーのリッチメニューを変更
              @line_api.change_linked_richmenu
              client.reply_message(event['replyToken'], message)
            else
              message = {
                type: 'text',
                text: "連携を開始します。\nしばらくお待ち下さい。"
              }

              client.reply_message(event['replyToken'], message)
              @line_api.push_integration_message
            end
          when '連携を解除する'
            @line_api.delete_rich_menu
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
