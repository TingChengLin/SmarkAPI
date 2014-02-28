class AddStuIdToPost < ActiveRecord::Migration
  def up
    add_column :posts, :stu_id, :integer
    remove_column :posts, :author
  end

  def down
    remove_column :posts, :stu_id
    add_column :posts, :author, :string
  end
end
