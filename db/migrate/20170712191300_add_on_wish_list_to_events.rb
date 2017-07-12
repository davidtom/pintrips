class AddOnWishListToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :on_wish_list, :boolean, default: false
  end
end
