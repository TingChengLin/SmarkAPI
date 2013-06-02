class Tag < ActiveRecord::Base
  has_and_belongs_to_many :bookmarks

  attr_accessible :name, :description

  def self.search(query)
    Tag.select("name, id").where("name like '#{query}%'")
  end

  def self.instance_search(query)
    self.search(query).map &lambda { |t| t.name }
  end
end
