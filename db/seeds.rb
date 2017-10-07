require 'csv'
require 'date'
require_relative '../app/models/station'
require_relative '../app/models/trip'

stations = (CSV.open'db/fixtures/station_fixture.csv', headers: true, header_converters: :symbol)

stations.each do |station|
  Station.create!(name:             station[:name],
                 dock_count:        station[:dock_count].to_i,
                 installation_date: Date.strptime(station[:installation_date], "%m/%d/%Y"),
                 city:              station[:city])
end

trips = (CSV.open'db/fixtures/trip_fixture.csv', headers: true, header_converters: :symbol)

trips.each do |trip|
  Trip.create!(duration:               trip[:duration],
              start_date:              Date.strptime(trip[:start_date], "%m/%d/%Y"),
              start_station_id:        trip[:start_station_id].to_i,
              end_date:                Date.strptime(trip[:end_date], "%m/%d/%Y"),
              end_station_id:          trip[:end_station_id].to_i,
              bike_id:                 trip[:bike_id].to_i,
              subscription_type:       trip[:subscription_type],
              zip_code:                trip[:zip_code])
end
