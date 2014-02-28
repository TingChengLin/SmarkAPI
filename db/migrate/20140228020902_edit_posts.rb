class EditPosts < ActiveRecord::Migration
  def up
    add_column :posts, :speaker, :string
    add_column :posts, :info, :text
    add_column :posts, :deadline, :datetime
    add_column :posts, :created_at, :datetime
    add_column :posts, :updated_at, :datetime
  end

  def down
    remove_column :posts, :speaker
    remove_column :posts, :info
    remove_column :posts, :deadline
    remove_column :posts, :created_at
    remove_column :posts, :updated_at
  end
end
