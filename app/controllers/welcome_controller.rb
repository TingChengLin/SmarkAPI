class WelcomeController < ApplicationController
  before_filter :token_auth!
  def index
    #render :text => "Smark!"
=begin
logger.info("1")

    client = EvernoteOAuth::Client.new(
      consumer_key: "lintingy-1512",
      consumer_secret: "67604440bd0b34c0",
      sandbox: true
    )

    client = EvernoteOAuth::Client.new

logger.info("2")

    request_token = client.request_token(:oauth_callback => '')
    request_token.authorize_url

    logger.info(request_token.authorize_url)
=end

  end

  def show
  end
end
