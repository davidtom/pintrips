class AddFeaturedToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :featured, :boolean
  end
end
