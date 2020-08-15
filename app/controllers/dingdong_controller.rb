require 'twilio-ruby'

class DingdongController < ApplicationController
  before_action :authenticate

  def create
    call = client.calls.create(
        to: ENV['PHONE_MIKE'],
        from: ENV['PHONE_TWILIO'],
        url: "http://demo.twilio.com/docs/voice.xml")
    call.to

    render plain: 'DINGDONG', status: :ok
  end

  private

  def client
    @client ||= Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'])
  end

  def authenticate # to keep web crawlers from dinging the dong
    unless request.headers['authorization'] == ENV['AUTH_HEADER']
      render plain: 'UNAUTHORIZED', status: :unauthorized
    end
  end
end
