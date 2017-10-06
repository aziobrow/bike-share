require 'csv'
require 'date'
require_relative '../app/models/station'

stations = (CSV.open'db/fixtures/station_fixture.csv', headers: true, header_converters: :symbol)

stations.each do |station|
  Station.create!(name:             station[:name],
                 dock_count:        station[:dock_count].to_i,
                 installation_date: Date.strptime(station[:installation_date], "%m/%d/%Y"),
                 city:              station[:city])
end
