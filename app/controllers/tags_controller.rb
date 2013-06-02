class TagsController < ApplicationController

  def index
    render :json => { :tags => Tag.select(:name).all }
  end

  def search
    render :json => [ Tag.instance_search(params[:query]) ]
  end

  def top
    tags = Tag.page(params[:page]).per(params[:per]).map &lambda { |t| t.profile }
    render :json => {
      :code => 200,
      :tags => tags
    }
  end

end
