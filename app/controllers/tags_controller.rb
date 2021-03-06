class TagsController < ApplicationController
  before_filter :token_auth!, :except => [:index, :show, :search, :top]

  def index
    case params[:orderby]
    when "use_count"
      #used_tags = Tag.joins(:bookmarks).select("*, COUNT(bookmarks.id) as use_count").group('tags.id').order("COUNT(bookmarks.id) DESC").page(params[:page]).per(params[:per]).map &lambda { |t| t.profile }
      tags = Tag.order("use_count DESC").page(params[:page]).per(params[:per]).map &lambda { |t| t.profile }
    when "subscribe_count"
      #used_tags = Tag.joins(:users).select("*, COUNT(users.id) as subscribe_count").group('tags.id').order("COUNT(users.id) DESC").page(params[:page]).per(params[:per]).map &lambda { |t| t.profile }
      tags = Tag.order("subscribe_count DESC").page(params[:page]).per(params[:per]).map &lambda { |t| t.profile }
    else
      tags = Tag.page(params[:page]).per(params[:per]).map &lambda { |t| t.profile }
    end
    render :json => { :status => "success",
                      :count => Tag.count,
                      :tags => tags },
           :callback => params[:callback]

  end

  def show
    tag = Tag.find(params[:id])
    render :json => { :status => "success",
                      :profile => tag.profile },
           :callback => params[:callback]
  end

  def search
    render :json => { :status => "success",
                      :tags => Tag.search(params[:query]) },
           :callback => params[:callback]
  end

  def top
    case params[:orderby]
    when "use_count"
      #tags = Tag.joins(:bookmarks).select("COUNT(bookmarks.id) as use_count").group('tags.id').order("COUNT(bookmarks.id) DESC").page(params[:page]).per(params[:per]).map &lambda { |t| t.profile }
      tags = Tag.order("use_count DESC").page(params[:page]).per(params[:per]).map &lambda { |t| t.profile }
    when "subscribe_count"
      #tags = Tag.joins(:users).select("COUNT(users.id) as subscribe_count").group('tags.id').order("COUNT(users.id) DESC").page(params[:page]).per(params[:per]).map &lambda { |t| t.profile }
      tags = Tag.order("subscribe_count DESC").page(params[:page]).per(params[:per]).map &lambda { |t| t.profile }
    else
      tags = Tag.page(params[:page]).per(params[:per]).map &lambda { |t| t.profile }
    end

    render :json => { :status => "success",
                      :count => Tag.count,
                      :tags => tags },
           :callback => params[:callback]
  end
end
