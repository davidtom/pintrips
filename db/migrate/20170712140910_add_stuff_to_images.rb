class AddStuffToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :title, :string
    add_column :images, :caption, :text
    add_column :images, :trip_id, :integer
  end
end
