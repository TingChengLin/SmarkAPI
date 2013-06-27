class UsersController < ApplicationController
  before_filter :token_auth!, :except => [:index]

  def index
    logger.info("current_user: #{current_user.to_json}")
    render :json => current_user,
           :callback => params[:callback]
  end

  def show
    render :json => { :name => @user.email.split("@")[0],
                      :fb_id => @user.facebook ? @user.facebook.uid : nil,
                      :tags => (@user.tags.map &lambda { |t| t.profile }),
                      :bookmarks => (@user.bookmarks.map &lambda { |b| b.profile }) },
           :callback => params[:callback]

  end
end
