class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render :json => (user.bookmarks.map &lambda { |b| b.profile })
  end
end
