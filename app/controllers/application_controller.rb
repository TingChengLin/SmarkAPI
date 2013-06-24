class ApplicationController < ActionController::Base
  # protect_from_forgery
  before_filter :allow_cross_domain_access

  def allow_cross_domain_access
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "*"
  end

  def token_auth!
    auth_token = params[:auth_token] || params[:state]
    unless auth_token
      render :json => { :error => "token not provided" },
             :callback => params[:callback]
      return
    end
    @user = User.find_by_authentication_token(auth_token)
    logger.info("token_auth!")
    logger.info("user: #{@user.to_json}")
    unless @user
      render :json => { :error => "invalid token" },
             :callback => params[:callback]
      return
    end
  end
end
