class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.text    :url
      t.string  :title
      t.string  :description

      t.timestamps
    end

    create_table :bookmarks_tags, :id => false do |t|
      t.integer :bookmark_id
      t.integer :tag_id
    end

    create_table :bookmarks_users, :id => false do |t|
      t.integer :user_id
      t.integer :bookmark_id
    end

  end
end
