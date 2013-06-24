class TagsController < ApplicationController

  def index
    render :json => { :tags => Tag.select(:name).all },
             :callback => params[:callback]
  end

  def show
    tag = Tag.find(params[:id])
    bookmarks = tag.bookmarks
    render :json => (bookmarks.map &lambda { |b| b.profile }),
             :callback => params[:callback]
  end

  def search
    render :json => [ Tag.instance_search(params[:query]) ],
             :callback => params[:callback]
  end

  def top
    tags = Tag.page(params[:page]).per(params[:per]).map &lambda { |t| t.profile }
    render :json => { :code => 200, :tags => tags },
             :callback => params[:callback]
  end

end
