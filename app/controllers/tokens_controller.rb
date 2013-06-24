require 'net/https'

class TokensController < ApplicationController

  def facebook
    profile = facebook_profile(params[:token])
    if profile
      user = User.find_or_create_from_facebook_profile(profile)
      if user
        sign_in(:user, user)
        render :json => { :user => user }
      else
        render :json => { :status => "insufficient permission" }
      end
    else
      render :json => { :status => "invalid token" }
    end
  end

private

  def facebook_profile(token)
    uri = URI.parse("https://graph.facebook.com/me?access_token=#{token}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    @data = http.get(uri.request_uri)
    if @data.code == "400"
      false
    else
      JSON.parse(@data.body)
    end
  end

end
