class UsersController < ApplicationController
  before_filter :token_auth!, :except => [:index, :show]

  def index
    if params[:tag_id]
      users = Tag.find(params[:tag_id]).users
    else
      users = User
    end
    users = users.all.map &lambda { |u| u.profile }
    # logger.info("current_user: #{current_user.to_json}")
    render :json => { :status => "success",
                      :users => users },
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
