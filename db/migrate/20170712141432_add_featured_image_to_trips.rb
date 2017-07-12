class AddFeaturedImageToTrips < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :featured_image_id, :integer
  end
end
