class AddTypeToKlass < ActiveRecord::Migration
  def change
    add_column :klasses, :tag, :string
  end
end
