class AddTypeToKlass < ActiveRecord::Migration
  def change
    add_column :klasses, :type, :string
  end
end
