describe 'User visits the trips dashboard' do
  before :each do
    date1 = DateTime.new(2017, 10, 8)
    date2 = DateTime.new(2017, 10, 7)
    @trip_1 = Trip.create(duration: 12, start_date: date2, start_station_id: 1, end_date: date1, end_station_id: 2, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345', condition_id: 1, original_station_id: 1)
    @trip_2 = Trip.create(duration: 120, start_date: date1, start_station_id: 2, end_date: date1, end_station_id: 2, bike_id: 3, subscription_type: 'Customer', zip_code: '12345', condition_id: 2, original_station_id: 2)
    @trip_3 = Trip.create(duration: 120, start_date: date1, start_station_id: 2, end_date: date2, end_station_id: 2, bike_id: 1, subscription_type: 'Customer', zip_code: '12345', condition_id: 2, original_station_id: 2)
    @station_1 = Station.create(installation_date: date1, dock_count: 4, name: 'Humberto', city: 'Place', original_station_id: 1)
    @station_2 = Station.create(installation_date: date1, dock_count: 4, name: 'Walter', city: 'Different Place', original_station_id: 2)
    Condition.create(date: date1, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
    Condition.create(date: date2, max_temperature: 60, mean_temperature: 40, min_temperature: 20, mean_humidity: 25, mean_visibility: 5, mean_wind_speed: 6, precipitation: 0.4)
  end

  it 'they can see the trips analytics' do
    visit "/trips-dashboard"

    expect(page).to have_content("Average Duration of Ride: 84")
    expect(page).to have_content("Longest Ride: 120")
    expect(page).to have_content("Shortest Ride: 12")
    expect(page).to have_content("Most Frequent Starting Station: Walter")
    expect(page).to have_content("Most Frequent Ending Station: Humberto")
    expect(page).to have_content("Rides Per Year: 2017:3")
    expect(page).to have_content("Rides Per Month: October:3")
    expect(page).to have_content("Most Ridden Bike: 3 Number of Rides: 2")
    expect(page).to have_content("Least Ridden Bike: 1 Number of Rides: 1")
    expect(page).to have_content("Users Subscribed: 1 Percentage: 33%")
    expect(page).to have_content("Users Not Subscribed: 2 Percentage: 67%")
    expect(page).to have_content("Date With Most Trips: 2017-10-08 Number of Trips: 2")
    expect(page).to have_content("Date With Least Trips: 2017-10-07 Number of Trips: 1")
    expect(page).to have_content("Max Temperature: 60 degrees")
    expect(page).to have_content("Average Temperature: 40 degrees")
    expect(page).to have_content("Min Temperature: 20 degrees")
    expect(page).to have_content("Average Humidity: 25 %")
    expect(page).to have_content("Average Visibility: 5 miles")
    expect(page).to have_content("Average Wind Speed: 6 miles per hour")
    expect(page).to have_content("Precipitation: 0.4 inches")
    expect(page).to have_content("Max Temperature: 100 degrees")
    expect(page).to have_content("Average Temperature: 50 degrees")
    expect(page).to have_content("Min Temperature: 0 degrees")
    expect(page).to have_content("Average Humidity: 50 %")
    expect(page).to have_content("Average Visibility: 10 miles")
    expect(page).to have_content("Average Wind Speed: 11 miles per hour")
    expect(page).to have_content("Precipitation: 0.2 inches")
  end
end
