require 'digest/md5'

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
    showed_user = User.find(params[:id])
    email_address = showed_user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    img = "http://www.gravatar.com/avatar/#{hash}"
    render :json => { :status => "success",
                      :name => showed_user.email.split("@")[0],
                      :img => img,
                      :fb_id => showed_user.facebook ? showed_user.facebook.uid : nil,
                      :tags => (showed_user.tags.map &lambda { |t| t.profile }),
                      :bookmarks => (showed_user.bookmarks.map &lambda { |b| b.profile }) },
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
