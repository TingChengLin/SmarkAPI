class Klass < ActiveRecord::Base
  has_many :posts
  attr_accessible :title, :speaker, :info, :deadline
end
