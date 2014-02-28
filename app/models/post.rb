class Post < ActiveRecord::Base
  belongs_to :klass
  attr_accessible :body, :klass_id, :author, :stu_id
end
