class Api::V1::LineBotController < ApplicationController
  require 'line/bot'
  require 'net/http'

  before_action :validate_signature, only: [:callback]
  before_action :parse_events, only: [:callback]
  before_action :set_user_id, only: [:callback]

  def callback
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        handle_message_event(event)
      when Line::Bot::Event::AccountLink
        handle_account_link_event(event)
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

  def validate_signature
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    error 400, 'Bad Request' unless client.validate_signature(request.body.read, signature)
  end

  def parse_events
    body = request.body.read
    @events = client.parse_events_from(body)
  end

  def set_user_id
    @user_id = @events[0]['source']['userId']
  end

  def handle_message_event(event)
    case event.type
    when Line::Bot::Event::MessageType::Text
      handle_text_message(event)
    when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
      handle_media_message(event)
    end
  end

  def handle_text_message(event)
    case event.message['text']
    when 'LINE連携'
      handle_line_integration_request
    when '連携を解除する'
      handle_unlink_request
    else
      reply_text_message(event.message['text'])
    end
  end

  def handle_line_integration_request
    if authenticated_user?
      reply_text_message('連携済みです')
      change_rich_menu
    else
      initiate_integration
    end
  end

  def handle_unlink_request
    delete_rich_menu
  end

  def handle_media_message(event)
    response = client.get_message_content(event.message['id'])
    tf = Tempfile.open('content')
    tf.write(response.body)
  end

  def handle_account_link_event(event)
    if event.result == 'ok'
      handle_successful_link(event)
    else
      handle_failed_link(event)
    end
  end

  def handle_successful_link(event)
    nonce = Nonce.find_by(val: event.nonce)
    user = nonce.user
    user.authentications.create(provider: 'line', uid: event['source']['userId'])
    reply_text_message('連携が完了しました。')
  end

  def handle_failed_link(_event)
    reply_text_message('連携に失敗しました。')
  end

  def reply_text_message(text)
    message = {
      type: 'text',
      text:
    }
    client.reply_message(@events[0]['replyToken'], message)
  end

  def authenticated_user?
    Authentication.exists?(provider: 'line', uid: @user_id)
  end

  def change_rich_menu
    uri = URI.parse("https://api.line.me/v2/bot/user/#{@user_id}/richmenu/#{ENV.fetch('LINE_MESSAGING_API_RICHMENU_ID',
                                                                                      nil)}")
    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Bearer #{ENV.fetch('LINE_MESSAGING_API_TOKEN', nil)}"
    Net::HTTP.start(uri.host, uri.port) do |http|
      http.request(request)
    end
  end

  def initiate_integration
    reply_text_message("連携を開始します。\nしばらくお待ち下さい。")
    link_token = request_link_token
    push_integration_message(link_token)
  end

  def request_link_token
    uri = URI.parse("https://api.line.me/v2/bot/user/#{@user_id}/linkToken")
    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Bearer #{ENV.fetch('LINE_MESSAGING_API_TOKEN', nil)}"
    response = Net::HTTP.start(uri.host, uri.port) do |http|
      http.request(request)
    end
    JSON(response.body)['linkToken']
  end

  def push_integration_message(link_token)
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
end
