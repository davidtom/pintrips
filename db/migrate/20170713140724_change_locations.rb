class ChangeLocations < ActiveRecord::Migration[5.1]
  def change
    remove_column :locations, :coordinates, :text
    add_column :locations, :lat, :string
    add_column :locations, :long, :string
  end
end
