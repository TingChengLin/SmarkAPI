require 'uri'
class Bookmark < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :tags
  has_many :votes

  attr_accessible :url, :title, :description

  def self.find_or_create(attributes)
    if attributes["title"].blank?
      url = attributes["url"]
      attributes["title"] = URI.parse(url).host
    end

    bookmark_attributes = attributes.slice("title", "url", "description")

    bookmark = Bookmark.where(bookmark_attributes).first
    if !bookmark
      bookmark = Bookmark.create(bookmark_attributes)
    end

    attributes["tags"].each do |t|
      logger.info("1: #{t}")

      tag = Tag.find_by_name(t)
      if tag && !(bookmark.tags.include? tag)
        logger.info("2: #{tag}")

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
    self_attr = self.attributes.slice("id", "title", "url", "description", "collect_count", "created_at")
    self_attr["tags"] = self.tags.map &lambda { |t| { :id => t.id, :name => t.name } }
    self_attr["votes"] = self.vote_up - self.vote_down
    self_attr
  end

end
