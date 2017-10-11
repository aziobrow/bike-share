class AddOriginalStationIdToTrips < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :original_station_id, :integer
  end
end
