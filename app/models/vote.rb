class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :bookmark

  # attr_accessible :title, :body
end
