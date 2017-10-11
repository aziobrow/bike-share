class AddOriginalStationIdColumnToStations < ActiveRecord::Migration[5.1]
  def change
    add_column :stations, :original_station_id, :integer
  end
end
