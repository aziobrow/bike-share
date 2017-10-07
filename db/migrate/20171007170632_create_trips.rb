class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.integer   :duration
      t.date  :start_date
      t.integer   :start_station_id
      t.date  :end_date
      t.integer   :end_station_id
      t.integer   :bike_id
      t.text      :subscription_type
      t.text      :zip_code
    end
  end

end
