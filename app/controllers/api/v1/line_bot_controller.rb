class Api::V1::LineBotController < ApplicationController
  require 'line/bot'

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)
    events.each do |event|
      user_id = event['source']['userId']
      reply_token = event['replyToken']
      @line_api = Api::LineApiRequest.new(user_id)
      auth = Authentication.find_by(provider: 'line', uid: user_id)

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          case event.message['text']
          when 'LINE連携'
            if auth
              @line_api.change_linked_richmenu
              reply_text_message(reply_token, '連携済みです')
            else
              # 連携URLを送信
              reply_text_message(reply_token, "連携を開始します。\nしばらくお待ち下さい。")
              @line_api.push_integration_message
            end
          when '連携を解除する'
            @line_api.delete_rich_menu
          end
        end
      when Line::Bot::Event::AccountLink
        if event.result == 'ok'
          nonce = Nonce.find_by(val: event.nonce)
          user = nonce.user
          user.authentications.create(provider: 'line', uid: user_id)
          reply_text_message(reply_token, '連携が完了しました。')
        else
          reply_text_message(reply_token, '連携に失敗しました。')
        end
      end
    end

    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch('LINE_MESSAGING_API_SECRET', nil)
      config.channel_token = ENV.fetch('LINE_MESSAGING_API_TOKEN', nil)
    end
  end

  def reply_text_message(reply_token, text)
    message = {
      type: 'text',
      text:
    }
    client.reply_message(reply_token, message)
  end
end
