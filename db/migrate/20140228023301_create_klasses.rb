class CreateKlasses < ActiveRecord::Migration
  def change
    create_table :klasses do |t|
      t.string    :title
      t.string    :speaker
      t.text      :info
      t.datetime  :deadline
      
      t.timestamps
    end
  end
end
