require "date"

class PostsController < ApplicationController
  def status
    posts 
    render :json => [
      {:title => "資種駭客鬆的第一堂課",
       :speaker => "駭客",
       :info => "1. 跟資種有關",
       :dealine => DateTime.new(2014,2,28,21,0,0,'+8'),
       :finished => 8}
    ]
  end
end
