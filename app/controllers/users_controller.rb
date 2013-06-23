class UsersController < ApplicationController
  before_filter :token_auth!, :except => [:index]

  def index
    logger.info("current_user: #{current_user.to_json}")
    render :json => current_user
  end

  def show
    #user = User.find(params[:id])
    render :json => (@user.bookmarks.map &lambda { |b| b.profile })
  end
end
