class RemoveFeaturedImageFromTrips < ActiveRecord::Migration[5.1]
  def change
    remove_column :trips, :featured_image_id
  end
end
