class TagsController < ApplicationController
  def search
    render :json => {
                      :code => 200,
                      :tags => Tag.instance_search(params[:query])
                    }
  end
end
