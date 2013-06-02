class BookmarksController < ApplicationController
  def search
    Bookmark.search(params[:query])
  end

end
