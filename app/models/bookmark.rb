require 'uri'
class Bookmark < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :tags

  attr_accessible :url, :title, :description

  def self.find_or_create(attributes)
    if !attributes["title"]
      url = attributes["url"]
      attributes["title"] = URI.parse(url).host
    end

    bookmark_attributes = attributes.slice("title", "url", "description")

    bookmark = Bookmark.where(bookmark_attributes).first
    if !bookmark
      bookmark = Bookmark.create(bookmark_attributes)
    end

    attributes["tags"].each do |t|
      tag = Tag.find_by_name(t)
      if tag && !(bookmark.tags.include? tag)
        bookmark.tags << tag
      end
    end
    bookmark
  end

  def self.search(query)
    tags = Tag.search(query)
    bookmarks = []
    tags.each do |tag|
      bookmarks += tag.bookmarks.map &lambda { |b| b.profile }
    end
    bookmarks.uniq
  end

  def profile
    self_attr = self.attributes.slice("title", "url", "description")
    self_attr["tags"] = self.tags.map &lambda { |t| t.name }
    self_attr
  end

end
