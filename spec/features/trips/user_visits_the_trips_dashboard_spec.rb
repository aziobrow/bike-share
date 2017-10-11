describe 'User visits the trips dashboard' do
  before :each do
    date1 = DateTime.new(2017, 10, 8)
    date2 = DateTime.new(2017, 10, 7)
    @trip_1 = Trip.create(duration: 12, start_date: date2, start_station_id: 1, end_date: date1, end_station_id: 2, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345')
    @trip_2 = Trip.create(duration: 120, start_date: date1, start_station_id: 2, end_date: date1, end_station_id: 2, bike_id: 4, subscription_type: 'Customer', zip_code: '12345')
    @station_1 = Station.create(installation_date: date1, dock_count: 4, name: 'Humberto', city: 'Place')
    @station_2 = Station.create(installation_date: date1, dock_count: 4, name: 'Walter', city: 'Different Place')
  end
  it 'they can see the trips analytics' do
    visit "/trips-dashboard"

    expect(page).to have_content("Average Duration of Ride: 66")
    expect(page).to have_content("Longest Ride: 120")
    expect(page).to have_content("Shortest Ride: 12")
    expect(page).to have_content("Most Frequent Starting Station: Humberto")
    expect(page).to have_content("Most Frequent Ending Station: Humberto")
    expect(page).to have_content("Rides Per Year: 2017:2")
    expect(page).to have_content("Rides Per Month: October:2")
    expect(page).to have_content("Most Ridden Bike: 4 Number of Rides: 1")
    expect(page).to have_content("Least Ridden Bike: 4 Number of Rides: 1")
    expect(page).to have_content("Users Subscribed: 1 Percentage: 50%")
    expect(page).to have_content("Users Not Subscribed: 1 Percentage: 50%")
    expect(page).to have_content("Date With Most Trips: 10/08/2017 Number of Trips: 2")
    expect(page).to have_content("Date With Least Trips: 10/08/2017 Number of Trips: 2")
  end
end
