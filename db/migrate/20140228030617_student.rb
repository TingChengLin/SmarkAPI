class Student < ActiveRecord::Migration
  def change
    create_table :student do |t|
      t.integer  :stu_id
      t.string   :stu_account
      t.string   :stu_password
      t.string   :name

      t.timestamps
    end
  end
end
