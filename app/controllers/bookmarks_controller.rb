class BookmarksController < ApplicationController
  before_filter :token_auth!, :except => [:index, :search, :top]

  def index
    case params[:orderby]
    when "collect_count"
      bookmarks = Bookmark.order("collect_count DESC").page(params[:page]).per(params[:per]).map &lambda { |b| b.profile }
    when "vote"
      bookmarks = Bookmark.select("*, (vote_up - vote_down) as vote").order("vote DESC").page(params[:page]).per(params[:per]).map &lambda { |b| b.profile }
    else
      bookmarks = Bookmark.order("id DESC").page(params[:page]).per(params[:per]).map &lambda { |b| b.profile }
    end
    #render :json => {
    #  :code => 200,
    #  :bookmarks => bookmarks
    #}
    logger.info("render: #{bookmarks.to_json}")
    render :json => { :status => "success",
                      :count => Bookmark.count,
                      :bookmarks => bookmarks },
           :callback => params[:callback]
  end

  def create
    bookmark = Bookmark.find_or_create(bookmark_params)
    #user = User.find_by_id(params[:id])

    if @user.bookmarks.include? bookmark
      render :json => { :status => "success",
                        :id => bookmark.id },
             :callback => params[:callback]
    else
      @user.bookmarks << bookmark
      #bookmark.collect_count += 1
      bookmark.save
      render :json => { :status => "success",
                        :id => bookmark.id },
             :callback => params[:callback]
    end
  end

  def collect
    @bookmark = Bookmark.find(params[:bookmark_id])
    # user = User.find(params[:user_id])

    if @user.bookmarks.include? bookmark
      render :json => { :code => 201 }, :callback => params[:callback]
    else
      @user.bookmarks << bookmark
      bookmark.collect_count += 1
      bookmark.save
      render :json => { :code => 200 }, :callback => params[:callback]
    end
  end

  def search
    render :json => { :bookmarks => Bookmark.search(params[:query])},
                    :callback => params[:callback]
  end

  def top
    case params[:orderby]
    when "collect_count"
      bookmarks = Bookmark.order("collect_count DESC").page(params[:page]).per(params[:per]).map &lambda { |b| b.profile }
    when "vote"
      bookmarks = Bookmark.select("*, (vote_up - vote_down) as vote").order("vote DESC").page(params[:page]).per(params[:per]).map &lambda { |b| b.profile }
    else
      bookmarks = Bookmark.order("id DESC").page(params[:page]).per(params[:per]).map &lambda { |b| b.profile }
    end
    #render :json => {
    #  :code => 200,
    #  :bookmarks => bookmarks
    #}
    logger.info("render: #{bookmarks.to_json}")
    render :json => { :status => "success",
                      :count => Bookmark.count,
                      :bookmarks => bookmarks },
           :callback => params[:callback]
  end

  def elect
    bookmark = Bookmark.find(params[:bookmark_id])
    # user = User.find(params[:user_id])

    if @user.votes.where(vote_params).first
      render :json => { :code => 201,
                        :vote_up => bookmark.vote_up,
                        :vote_down => bookmark.vote_down },
             :callback => params[:callback]
    else
      if (params[:vote] == 1) || (params[:vote] == "1")
        bookmark.vote_up += 1
        bookmark.total_votes += 1
      else (params[:vote] == -1) || (params[:vote] == "-1")
        bookmark.vote_down += 1
        bookmark.total_votes -= 1
      end
      bookmark.save
      @user.votes.create(vote_params)

      render :json => {:code => 200,
                       :vote_up => bookmark.vote_up,
                       :vote_down => bookmark.vote_down},
             :callback => params[:callback]
    end
  end

private
  def bookmark_params
    params.slice("url", "title", "description", "tags")
  end

  def vote_params
    params.slice("bookmark_id", "vote")
  end
end
