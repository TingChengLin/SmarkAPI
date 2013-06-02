class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :bookmark

  attr_accessible :user_id, :bookmark_id, :vote
end
