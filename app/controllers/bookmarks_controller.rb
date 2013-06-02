class BookmarksController < ApplicationController
  def create
    bookmark = Bookmark.create(bookmark_params)
    params[:tags].each do |t|
      tag = Tag.find_by_name(t)
      bookmark.tags << tag
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
    params.slice("url", "title", "description")
  end

end
