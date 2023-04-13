class EditRouteColumnNames < ActiveRecord::Migration[7.0]
  def change
    change_table :routes do |t|
      t.rename :pick_up_address, :start_address
      t.rename :destination_address, :end_address
    end
  end
end