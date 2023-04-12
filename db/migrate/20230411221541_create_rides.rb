class CreateRides < ActiveRecord::Migration[7.0]
  def change
    create_table :rides do |t|
      t.string :driver_id
      t.string :route_id
      t.datetime :pick_up_at

      t.timestamps
    end
  end
end
