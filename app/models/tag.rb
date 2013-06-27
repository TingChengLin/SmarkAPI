class Tag < ActiveRecord::Base
  has_and_belongs_to_many :bookmarks
  has_and_belongs_to_many :users

  attr_accessible :name, :description

  def self.search(query)
    Tag.select("name, id").where("name like '#{query}%'")
  end

  def self.instance_search(query)
    self.search(query).map &lambda { |t| t.name }
  end

  def profile
    self.attributes.slice("name", "description")
  end

end
