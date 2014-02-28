class Klass < ActiveRecord::Base
  has_many :posts
  attr_accessible :title, :speaker, :info, :deadline, :tag

  def profile
    {:title => self.title,
     :speaker => self.speaker,
     :info => self.info,
     :dealine => self.deadline.strftime("%B %d, %Y %H:%M:%S"),
     :tag => self.tag,
     :count_down => (self.deadline - Time.now).to_i,
     :finished => self.posts.count}
  end
end
