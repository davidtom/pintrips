class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.text :review
      t.integer :rating
      t.datetime :date
      t.integer :trip_id

      t.timestamps
    end
  end
end
