describe "when a user visits the trips index" do
  before :each do
    date1 = DateTime.new(2017, 10, 8)
    date2 = DateTime.new(2017, 10, 7)
    @trip_1 = Trip.create(duration: 12, start_date: date2, start_station_id: 1, end_date: date1, end_station_id: 2, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345')
    @trip_2 = Trip.create(duration: 120, start_date: date1, start_station_id: 2, end_date: date1, end_station_id: 2, bike_id: 4, subscription_type: 'Subscriber', zip_code: '12345')
  end

  it "they see trips and dates" do

    visit '/trips'

    expect(page).to have_content("2017-10-07")
    expect(page).to have_content("2017-10-08")
    find("h3", :text => '1')
  end

end
