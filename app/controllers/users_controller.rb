class UsersController < ApplicationController
  before_filter :token_auth!, :except => [:index]

  def index
    logger.info("current_user: #{current_user.to_json}")
    render :json => { :status => "success",
                      :user => current_user },
           :callback => params[:callback]
  end

  def show
    render :json => { :status => "success",
                      :name => @user.email.split("@")[0],
                      :fb_id => @user.facebook ? @user.facebook.uid : nil,
                      :tags => (@user.tags.map &lambda { |t| t.profile }),
                      :bookmarks => (@user.bookmarks.map &lambda { |b| b.profile }) },
           :callback => params[:callback]

  end

  def subscribe
    @user.subscribe(params[:tag_id])
    tags = @user.tags.map &lambda { |t| t.profile }
    render :json => { :status => "success",
                      :tags => tags },
           :callback => params[:callback]
  end

end
