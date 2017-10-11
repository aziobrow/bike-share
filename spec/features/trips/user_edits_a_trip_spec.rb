describe "when a user visits trip edit page" do

  before :each do
    date1 = DateTime.new(2017, 10, 8)
    date2 = DateTime.new(2017, 10, 7)
    @trip_1 = Trip.create(duration: 12, start_date: date2, start_station_id: 1, end_date: date1, end_station_id: 2, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345')
    @station_1 = Station.create(installation_date: date1, dock_count: 4, name: 'Humberto', city: 'Place')
    @station_2 = Station.create(installation_date: date1, dock_count: 4, name: 'Walter', city: 'Different Place')
  end
  it "they see the trip edit form" do
    visit "/trips/#{@trip_1.id}/edit"

    expect(page).to have_content("Start Date")
    expect(page).to have_content("Start Station ID")
    expect(page).to have_content("End Date")
    expect(page).to have_content("End Station ID")
    expect(page).to have_content("Bike ID")
    expect(page).to have_content("Subscription Type")
    expect(page).to have_content("Zip Code")
  end

  it "they can edit a trip" do
    visit "/trips/#{@trip_1.id}/edit"

    fill_in("trip[start_date]", with: '2017-10-9')
    fill_in("trip[start_station_id]", with: '1')
    fill_in("trip[end_date]", with: '2017-10-10')
    fill_in("trip[end_station_id]", with: '2')
    fill_in("trip[bike_id]", with: '10')
    fill_in("trip[subscription_type]", with: 'Subscriber')
    fill_in("trip[zip_code]", with: '12345')

    click_on("Save Changes")

    expect(current_path).to eq("/trips/#{@trip_1.id}")

    expect(page).to have_content("Start Date: 2017-10-09")
    expect(page).to have_content("Starting Station: Humberto")
    expect(page).to have_content("End Date: 2017-10-10")
    expect(page).to have_content("Ending Station: Walter")
    expect(page).to have_content("Bike Used: 10")
    expect(page).to have_content("Subcription Type: Subscriber")
    expect(page).to have_content("Zip Code: 12345")
  end
end