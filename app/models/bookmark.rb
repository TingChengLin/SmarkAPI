class Bookmark < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :tags

  attr_accessible :url, :title, :description

  def self.search(query)
    tags = Tag.search(query)
    bookmarks = []
    tags.each do |tag|
      bookmarks += tag.bookmarks.map &lambda { |b| b.profile }
    end
    bookmarks.uniq
  end

  def profile
    self.attributes.slice("title", "url", "description")
  end

end
