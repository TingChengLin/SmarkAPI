class SessionsController < ApplicationController
  before_filter :token_auth!, :only => [:destroy]

  def create
    @user = User.find_by_email(params[:email])
    unless @user
      logger.info("error: email not exist")
      render :json => { :status => "error",
                        :message => "accout with this email not exist" },
             :callback => params[:callback]
      return
    end

    if @user.valid_password?(params[:password])
      sign_in(@user)
      logger.info("success: user created")
      logger.info("current_user: #{@user.to_json}")
      render :json => { :status => "success",
                        :id => @user.id,
                        :auth_token => @user.authentication_token,
                        :services => @user.services },
             :callback => params[:callback]
      return
    else
      logger.info("error: password error")
      warden.custom_failure!
      render :json => { :status => "error",
                        :message => @user.errors.to_json },
             :callback => params[:callback]
      #render :json=> user.errors, :status=>422,
      #       :callback => params[:callback]
    end
  end

  def destroy
    logger.info("session destroy!")
    logger.info("#{current_user.to_json}")
    @user.update_attribute(:authentication_token, nil)
    sign_out(@user)

    render :json => { :status => "success",
                   :id => @user.id },
           :callback => params[:callback]
  end
end
