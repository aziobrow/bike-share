describe "User visits condition dashboard page" do
  before :each do
    date1 = DateTime.new(2017, 10, 8)
    date2 = DateTime.new(2017, 10, 7)
    @trip_1 = Trip.create(duration: 12, start_date: date2, start_station_id: 1, end_date: date1, end_station_id: 2, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345', condition_id: 1)
    @trip_2 = Trip.create(duration: 120, start_date: date1, start_station_id: 2, end_date: date1, end_station_id: 2, bike_id: 3, subscription_type: 'Customer', zip_code: '12345', condition_id: 2)
    @trip_3 = Trip.create(duration: 120, start_date: date1, start_station_id: 2, end_date: date2, end_station_id: 2, bike_id: 1, subscription_type: 'Customer', zip_code: '12345', condition_id: 2)
    @station_1 = Station.create(installation_date: date1, dock_count: 4, name: 'Humberto', city: 'Place')
    @station_2 = Station.create(installation_date: date1, dock_count: 4, name: 'Walter', city: 'Different Place')
    @condition_1 = Condition.create(date: date1, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
    @condition_2 = Condition.create(date: date2, max_temperature: 60, mean_temperature: 40, min_temperature: 20, mean_humidity: 25, mean_visibility: 5, mean_wind_speed: 6, precipitation: 0.4)
  end

  it "they see all the dashboard analytics" do
    visit "/conditions-dashboard"

    expect(page).to have_content("Breakdown of Trips Taken Per Ten Degree Temperature Range")
    expect(page).to have_content("Range: 60 - 69: degrees")
    expect(page).to have_content("Range: 70 - 79: degrees")
    expect(page).to have_content("Range: 80 - 89: degrees")
    expect(page).to have_content("Range: 90 - 99: degrees")
    expect(page).to have_content("Range: 0 - 0.49: inches")
    expect(page).to have_content("Breakdown of Trips Taken by 4 miles per hour of Wind Speed")
    expect(page).to have_content("Range: 0 - 3.99: miles per hour")
    expect(page).to have_content("Range: 4 - 7.99: miles per hour")
    expect(page).to have_content("Range: 8 - 11.99: miles per hour")
    expect(page).to have_content("Breakdown of Trips Taken by 4 miles of Visibility")
    expect(page).to have_content("Range: 0 - 3.99: miles")
    expect(page).to have_content("Range: 4 - 7.99: miles")
    expect(page).to have_content("Range: 8 - 11.99: miles")
    expect(page).to have_content("Average Rides")
    expect(page).to have_content("Maximum Rides")
    expect(page).to have_content("Minimum Rides")
  end
end