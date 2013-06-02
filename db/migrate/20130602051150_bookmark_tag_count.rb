class BookmarkTagCount < ActiveRecord::Migration
  def change
    add_column :bookmarks, :collect_count, :integer
    add_column :bookmarks, :vote_up, :integer
    add_column :bookmarks, :vote_down, :integer

    add_column :tags, :tag_with_count, :integer

    add_column :users, :following_count, :integer
    add_column :users, :follower_count, :integer
  end

end
