class AddOnWishListToTrip < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :on_wish_list, :boolean, default: false
  end
end
