describe "When a user visits a trip show page" do
  before :each do
    date1 = DateTime.new(2017, 10, 8)
    date2 = DateTime.new(2017, 10, 7)
    @station = Station.create(installation_date: date1, dock_count: 4, name: 'Humberto', city: 'Place')
    @trip_1 = Trip.create(duration: 1440, start_date: date2, start_station_id: 1, end_date: date1, end_station_id: 1, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345')
  end

  it 'they see a trips information' do
    visit "/trips/#{@trip_1.id}"

    expect(page).to have_content("trip ID: 1")
    expect(page).to have_content("Duration in Minutes: 24")
    expect(page).to have_content("Start Date: 2017-10-07")
    expect(page).to have_content("Starting Station: Humberto")
    expect(page).to have_content("End Date: 2017-10-08")
    expect(page).to have_content("Ending Station: Humberto")
    expect(page).to have_content("Bike Used: 3")
    expect(page).to have_content("Subcription Type: Subscriber")
    expect(page).to have_content("Zip Code: 12345")
  end
end
