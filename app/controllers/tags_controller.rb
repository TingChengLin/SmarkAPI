class TagsController < ApplicationController
  def search
    render :json => {
                      :code => 200,
                      :tags => Tag.instance_search(params[:query])
                    }
  end

  def top
    render :json => {
      :code => 200,
      :bookmarks => (Tag.all.map &lambda { |t| t.profile })
    }
  end

end
