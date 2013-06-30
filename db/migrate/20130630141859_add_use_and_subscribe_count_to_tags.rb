class AddUseAndSubscribeCountToTags < ActiveRecord::Migration
  def change
    add_column :tags, :use_count, :string
    add_column :tags, :subscribe_count, :string
  end
end
