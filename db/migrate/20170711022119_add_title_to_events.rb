class AddTitleToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :title, :text
  end
end
