class CreateAuthorizations < ActiveRecord::Migration
  def up
    remove_column :users, :provider
    remove_column :users, :uid
    remove_column :users, :name

    create_table :authorizations do |t|
      t.string :provider
      t.integer :user_id
      t.string :uid

      t.timestamps
    end
  end

  def down
    drop_table :authorizations

    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
  end
end
