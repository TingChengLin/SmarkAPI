class BookmarksController < ApplicationController
  def create
    Bookmark.create(bookmark_params)
  end

  def search
    render :json => {
                      :code => 200,
                      :bookmarks => Bookmark.search(params[:query])
                    }
  end

private
  def bookmark_params
    params.slice("url", "title", "description")
  end

end
