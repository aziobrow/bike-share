class CreateStations < ActiveRecord::Migration[5.1]
  def change
    create_table :stations do |t|
      t.text      :name
      t.integer   :dock_count
      t.text      :city
      t.datetime  :installation_date
    end
  end
  
end
