require 'oauth'
require 'oauth/consumer'
require 'evernote_oauth'
require 'cgi'


#OAUTH_CONSUMER_KEY = "lintingy-0414"
#OAUTH_CONSUMER_SECRET = "f24a88a58ffb61a4"

#SANDBOX = false

FB_APP_ID = "603714572980258"
FB_CLIENT_SECRET = "0ef08c2522f552d04208a309b808521e"


#HOST = "localhost"
#PORT = 3000
HOST = "api.smark.cc"
PORT = 80

class AuthorizationsController < ApplicationController
  before_filter :token_auth!

  def evernote
    callback_url = url_for(:controller => "authorizations",
                           :action => "evernote_callback",
                           :host => HOST,
                           :port => PORT)
    puts "callback_url: #{callback_url}"

    # pass user param by uri param
    callback_url = "#{callback_url}?state=#{@user.authentication_token}"

    session[:request_token] = client.request_token(:oauth_callback => callback_url)
    redirect_to session[:request_token].authorize_url
  end

  def evernote_callback
    session[:oauth_verifier] = params['oauth_verifier']
    #session[:access_token] = session[:request_token].get_access_token(:oauth_verifier => session[:oauth_verifier])
    session[:access_token] = session[:request_token].get_access_token(:oauth_verifier => session[:oauth_verifier])
    logger.info( "params: #{params}")
    logger.info( "access_token: #{session[:access_token].to_json}")

    @user.bind_evernote(session[:access_token].token)

    #create_note
    if guid = get_smark_notebook_guid
      logger.info("guid: #{guid}")
    else
      notebook = create_notebook
      create_intro_note
      logger.info("notebook: #{notebook}")
    end


    #render :json => { :status => "success",
    #                  :oauth_verifier => session[:oauth_verifier],
    #                  :access_token => session[:access_token],
    #                  :username => client.user_store.getUser(auth_token),
    #                  :notebooks => client.note_store.listNotebooks(auth_token) },
    #       :callback => params[:callback]
    #render :text => "Connect with Evernote Success!"
    redirect_to "http://smark.cc/"
  end


  def facebook
    user_id = current_user.id

    callback_url = url_for(:controller => "authorizations",
                           :action => "facebook_callback",
                           :host => HOST,
                           :port => PORT)

    # pass the user params using state
    redirect_to "https://www.facebook.com/dialog/oauth?client_id=#{FB_APP_ID}&redirect_uri=#{callback_url}&state=#{user_id}"
  end

  def facebook_callback
    code = params[:code]
    callback_url = url_for(:controller => "authorizations",
                           :action => "facebook_callback",
                           :host => HOST,
                           :port => PORT)

    uri = URI.parse("https://graph.facebook.com/oauth/access_token?client_id=#{FB_APP_ID}&redirect_uri=#{callback_url}&client_secret=#{FB_CLIENT_SECRET}&code=#{code}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    @data = http.get(uri.request_uri)

    puts CGI::parse(@data.body)

    render :json => CGI::parse(@data.body)
  end


private
  def create_notebook
    # client = EvernoteOAuth::Client.new(token: auth_token)
    note_store = client.note_store

    notebook = Evernote::EDAM::Type::Notebook.new
    notebook.name = "Smark"

    created_notebook = note_store.createNotebook(notebook)
    note_store.getNotebook(created_notebook.guid)
  end


  def auth_token
    session[:access_token].token if session[:access_token]
  end

  def client
    @client ||= EvernoteOAuth::Client.new(token: auth_token, consumer_key:OAUTH_CONSUMER_KEY, consumer_secret:OAUTH_CONSUMER_SECRET, sandbox: SANDBOX)
  end


end
