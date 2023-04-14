class CreateRoutes < ActiveRecord::Migration[7.0]
  def change
    create_table :routes do |t|
      t.string :pick_up_address
      t.string :destination_address
      t.integer :time_minutes 
      t.integer :distance_miles
      t.timestamps
    end
  end
end
