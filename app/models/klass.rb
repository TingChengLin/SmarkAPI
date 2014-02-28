class Klass < ActiveRecord::Base
  has_many :posts
  attr_accessible :title, :speaker, :info, :deadline

  def profile
    {:title => self.title,
     :speaker => self.speaker,
     :info => self.info,
     :dealine => self.deadline,
     :finished => self.posts.count}
  end
end
