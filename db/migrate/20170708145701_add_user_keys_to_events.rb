class AddUserKeysToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :user_id, :integer
    add_column :events, :location_id, :integer
    add_column :events, :type_id, :integer
  end
end
