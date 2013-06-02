class BookmarksController < ApplicationController

  def create
    bookmark = Bookmark.find_or_create(bookmark_params)
    user = User.find_by_uid(params[:uid])

    if user
      user.collect(bookmark)
    end

    render :json => { :code => 200 }
  end

  def search
    render :json => {
                      :code => 200,
                      :bookmarks => Bookmark.search(params[:query])
                    }
  end

  def top
    bookmarks = Bookmark.page(params[:page]).per(params[:per]).map &lambda { |b| b.profile }
    render :json => {
      :code => 200,
      :bookmarks => bookmarks
    }
  end

private
  def bookmark_params
    params.slice("url", "title", "description", "tags")
  end

end
