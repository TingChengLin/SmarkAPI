class BookmarksController < ApplicationController

  def create
    bookmark = Bookmark.find_or_create(bookmark_params)
    user = User.find_by_uid(params[:uid])

    if user.bookmarks.include? bookmark
      render :json => { :code => 201 }
    else
      self.bookmarks << bookmark
      bookmark.collect_count += 1
      bookmark.save
      render :json => { :code => 200 }
    end
  end

  def search
    render :json => {
                      #:code => 200,
                      :bookmarks => Bookmark.search(params[:query])
                    }
  end

  def top
    bookmarks = Bookmark.page(params[:page]).per(params[:per]).map &lambda { |b| b.profile }
    #render :json => {
    #  :code => 200,
    #  :bookmarks => bookmarks
    #}
    render :json => bookmarks
  end

  def elect
    bookmark = Bookmark.find(params[:bookmark_id])
    if params[:vote] == 1 || "-1"
      bookmark.vote_up += 1
    else params[:vote] == -1 || "-1"
      bookmark.vote_down += 1
    end
    bookmark.save
    render :json => {:vote_up => bookmark.vote_up,
                     :vote_down => bookmark.vote_down}
  end

private
  def bookmark_params
    params.slice("url", "title", "description", "tags")
  end

end
