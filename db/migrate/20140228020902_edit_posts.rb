class EditPosts < ActiveRecord::Migration
  def up
    add_column :posts, :klass_id, :integer

    add_column :posts, :author, :datetime

    add_column :posts, :created_at, :datetime
    add_column :posts, :updated_at, :datetime
  end

  def down
    add_column :posts, :klass_id

    remove_column :posts, :author

    remove_column :posts, :created_at
    remove_column :posts, :updated_at
  end
end
