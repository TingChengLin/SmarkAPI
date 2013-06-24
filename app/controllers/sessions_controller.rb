class SessionsController < ApplicationController
  before_filter :token_auth!, :only => [:destroy]

  def create
    @user = User.find_by_email(params[:email])
    unless @user
      render :json => { :error => "invalid email" },
             :callback => params[:callback]
      return
    end

    if @user.valid_password?(params[:password])
      sign_in(@user)
      logger.info("current_user: #{current_user.to_json}")
      render :json=> { :id => @user.id, :auth_token => @user.authentication_token },
             :callback => params[:callback]
      return
    else
      warden.custom_failure!
      render :json=> user.errors, :status=>422,
             :callback => params[:callback]
    end
  end

  def destroy
    logger.info("session destroy!")
    logger.info("#{current_user.to_json}")
    @user.update_attribute(:authentication_token, nil)
    sign_out(@user)

    render :json => @user,
           :callback => params[:callback]
  end
end
