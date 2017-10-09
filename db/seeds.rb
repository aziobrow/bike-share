require 'csv'
require 'date'
require 'pry'
require_relative '../app/models/station'
require_relative '../app/models/trip'
require_relative '../app/models/condition'

stations = (CSV.open'db/fixtures/station_fixture.csv', headers: true, header_converters: :symbol)

stations.each do |station|
  Station.create!(name:             station[:name],
                 dock_count:        station[:dock_count].to_i,
                 installation_date: Date.strptime(station[:installation_date], "%m/%d/%Y"),
                 city:              station[:city],
                 station_id:        station[:id])
end

conditions = (CSV.open'db/fixtures/weather_fixture.csv', headers: true, header_converters: :symbol)

conditions.each do |condition|
  if condition[:zip_code] == "94107"
    Condition.create!(date:              Date.strptime(condition[:date], "%m/%d/%Y"),
                max_temperature:         condition[:max_temperature_f].to_i,
                mean_temperature:        condition[:mean_temperature_f].to_i,
                min_temperature:         condition[:min_temperature_f].to_i,
                mean_humidity:           condition[:mean_humidity].to_i,
                mean_visibility:         condition[:mean_visibility_miles].to_i,
                mean_wind_speed:         condition[:mean_wind_speed_mph].to_i,
                precipitation:           condition[:precipitation_inches].to_f)
  end
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
              zip_code:                trip[:zip_code],
              condition_id:            Condition.find_condition_id(trip[:start_date]))
end
