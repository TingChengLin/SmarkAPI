class AddUseAndSubscribeCountToTags < ActiveRecord::Migration
  def change
    add_column :tags, :use_count, :integer, :default => 0
    add_column :tags, :subscribe_count, :integer, :default => 0
  end
end
