class Student < ActiveRecord::Base
  self.set_table_name "student"

  has_many :posts
end
