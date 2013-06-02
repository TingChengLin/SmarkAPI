class TagsController < ApplicationController
  def search
    render :json => {
                      :code => 200,
                      :tags => Tag.search(params[:query])
                    }
  end
end
