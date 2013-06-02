class AddDefaultToBookmarks < ActiveRecord::Migration
  def change
    change_column :bookmarks, :collect_count, :integer, :default => 1
    change_column :bookmarks, :vote_up, :integer, :default => 0
    change_column :bookmarks, :vote_down, :integer, :default => 0
  end
end
