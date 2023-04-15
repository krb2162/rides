class ChangeFkeyDataTypesInRides < ActiveRecord::Migration[7.0]
  def change
    change_table :rides do |t|
      t.change :driver_id, :integer
      t.change :route_id, :integer
    end
  end
end
