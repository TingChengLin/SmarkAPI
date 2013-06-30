class RegistrationsController < ApplicationController
  def create
    logger.info("registration create")
    logger.info("params: #{params.to_json}")

    @user = User.new(:email => params[:email], :password => params[:password])
    if @user.save
      render :json=> { :id => @user.id, :auth_token => @user.authentication_token },
             :callback => params[:callback]
      return
    else
      #render :json => { :error => "user already exist" },
      #       :callback => params[:callback]
      warden.custom_failure!
      #render :json=> @user.errors, :status=>422
      render :json => { :status => "error",
                        :message => @user.errors.to_json },
             :callback => params[:callback]
    end
  end
end
