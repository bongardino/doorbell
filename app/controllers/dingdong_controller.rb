require 'twilio-ruby'

class DingdongController < ApplicationController
  before_action :authenticate

  def create
    call = client.calls.create(
        to: ENV['PHONE_MIKE'],
        from: ENV['PHONE_TWILIO'],
        url: "https://handler.twilio.com/twiml/EH9d02e231dc8569adccb70bbb5e84015c") #twiml-bins/hangup
    call.to

    render plain: 'DINGDONG', status: :ok
  end

  private

  def client
    @client ||= Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'])
  end

  def authenticate # keep web crawlers from dinging the dong
    unless request.headers['authorization'] == ENV['AUTH_HEADER']
      render plain: 'UNAUTHORIZED', status: :unauthorized
    end
  end
end
