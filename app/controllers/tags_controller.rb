class TagsController < ApplicationController

  def index
    case params[:orderby]
    when "use_count"
      tags = Tag.joins(:bookmarks).select("COUNT(bookmarks.id) as use_count").group('tags.id').order("COUNT(bookmarks.id) DESC")
    when "subscribe_count"
      tags = Tag.joins(:users).select("COUNT(users.id) as subscribe_count").group('tags.id').order("COUNT(users.id) DESC")
    else
      tags = Tag.select(:name).all
    end
    render :json => { :tags => tags },
           :callback => params[:callback]

  end

  def show
    tag = Tag.find(params[:id])
    bookmarks = tag.bookmarks
    render :json => (bookmarks.map &lambda { |b| b.profile }),
             :callback => params[:callback]
  end

  def search
    render :json => { :tags => Tag.instance_search(params[:query]) },
             :callback => params[:callback]
  end

  def top
    tags = Tag.page(params[:page]).per(params[:per]).map &lambda { |t| t.profile }
    render :json => { :code => 200, :tags => tags },
             :callback => params[:callback]
  end

end
