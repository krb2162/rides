class CreateRides < ActiveRecord::Migration[7.0]
  def change
    create_table :rides do |t|
      t.string :start_address
      t.string :destination_address
      t.string :status
      t.date_time :start_at
      t.string :driver_id

      t.timestamps
    end
  end
end
