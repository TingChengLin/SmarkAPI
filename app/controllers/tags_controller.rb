class TagsController < ApplicationController
  def search
    render :json => {
                      :code => 200,
                      :tags => Tag.instance_search(params[:query])
                    }
  end

  def top
    tags = Tag.page(params[:page]).per(params[:per]).map &lambda { |t| t.profile }
    render :json => {
      :code => 200,
      :tags => tags
    }
  end

end
