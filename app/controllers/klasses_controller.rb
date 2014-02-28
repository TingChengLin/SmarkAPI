class KlassesController < ApplicationController
  def status
    k = Klass.first
    render :json => [
      {:title => k.title,
       :speaker => k.speaker,
       :info => k.info,
       :dealine => k.deadline,
       :finished => k.posts.count}
    ]
  end
end
