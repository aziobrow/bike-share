class AddOriginalStationIdColumnToStations < ActiveRecord::Migration[5.1]
  def change
    add_column :stations, :station_id, :integer
  end
end
