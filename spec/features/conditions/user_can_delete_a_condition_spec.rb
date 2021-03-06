describe "User visits the condition index page" do
  before :each do
    date1 = DateTime.new(2017, 10, 8)
    date2 = DateTime.new(2017, 10, 7)
    @trip_1 = Trip.create(duration: 12, start_date: date2, start_station_id: 1, end_date: date1, end_station_id: 2, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345', condition_id: 1)
    @trip_2 = Trip.create(duration: 120, start_date: date1, start_station_id: 2, end_date: date1, end_station_id: 2, bike_id: 3, subscription_type: 'Customer', zip_code: '12345', condition_id: 2)
    @trip_3 = Trip.create(duration: 120, start_date: date1, start_station_id: 2, end_date: date2, end_station_id: 2, bike_id: 1, subscription_type: 'Customer', zip_code: '12345', condition_id: 2)
    @station_1 = Station.create(installation_date: date1, dock_count: 4, name: 'Humberto', city: 'Place')
    @condition_1 = Condition.create(date: date1, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
  end

  it 'they can delete a condition' do
    visit "/conditions"

    visit "/conditions/#{@condition_1.id}"

    click_on("Delete")

    expect(current_path).to eq("/conditions")

    expect(page).to_not have_content("2017-10-08")
  end
end