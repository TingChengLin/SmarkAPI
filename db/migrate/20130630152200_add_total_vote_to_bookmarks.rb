class AddTotalVoteToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :total_votes, :string, :default => 0
  end
end
