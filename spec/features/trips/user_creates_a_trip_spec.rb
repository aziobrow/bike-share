describe "when a user visits trip new page" do

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
  it "they see the new trip form" do
    visit "/trips/new"

    expect(page).to have_content("Start Date")
    expect(page).to have_content("Start Station ID")
    expect(page).to have_content("End Date")
    expect(page).to have_content("End Station ID")
    expect(page).to have_content("Bike ID")
    expect(page).to have_content("Subscription Type")
    expect(page).to have_content("Zip Code")
  end

  it "they can create a trip" do
    visit "/trips/new"

    fill_in("trip[start_date]", with: '2017-10-9')
    fill_in("trip[start_station_id]", with: '1')
    fill_in("trip[end_date]", with: '2017-10-10')
    fill_in("trip[end_station_id]", with: '2')
    fill_in("trip[bike_id]", with: '10')
    fill_in("trip[subscription_type]", with: 'Subscriber')
    fill_in("trip[zip_code]", with: '12345')

    click_on("Create Trip")

    expect(current_path).to eq("/trips")

    visit "/trips/1"

    expect(page).to have_content("Start Date: 2017-10-07")
    expect(page).to have_content("Starting Station: Humberto")
    expect(page).to have_content("End Date: 2017-10-08")
    expect(page).to have_content("Ending Station: Walter")
    expect(page).to have_content("Bike Used: 3")
    expect(page).to have_content("Subcription Type: Subscriber")
    expect(page).to have_content("Zip Code: 12345")
  end
end
