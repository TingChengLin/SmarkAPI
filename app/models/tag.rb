class Tag < ActiveRecord::Base
  has_and_belongs_to_many :bookmarks

  attr_accessible :name, :description

end
