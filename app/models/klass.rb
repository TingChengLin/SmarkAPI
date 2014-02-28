class Klass < ActiveRecord::Base
  has_many :posts
  attr_accessible :title, :speaker, :info, :deadline, :type

  def profile
    {:title => self.title,
     :speaker => self.speaker,
     :info => self.info,
     :dealine => self.deadline,
     :type => self.type,
     :finished => self.posts.count}
  end
end
