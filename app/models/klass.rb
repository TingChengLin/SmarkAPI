class Klass < ActiveRecord::Base
  has_many :posts
  attr_accessible :title, :speaker, :info, :deadline, :tag

  def profile
    {:title => self.title,
     :speaker => self.speaker,
     :info => self.info,
     :dealine => self.deadline,
     :tag => self.tag,
     :finished => self.posts.count}
  end
end
