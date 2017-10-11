describe "User visits condition edit page" do
  before :each do
    date = DateTime.new(2010, 10, 10)
    date1 = DateTime.new(2010, 10, 11)
    Trip.create(duration: 12, start_date: date, start_station_id: 1, end_date: date1, end_station_id: 2, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345')
    @condition1 = Condition.create(date: date, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
  end

  it "they see the edit condition form" do
    visit "conditions/#{@condition1.id}/edit"

    expect(page).to have_content("Enter New Date:")
    expect(page).to have_content("Enter New High Temperature:")
    expect(page).to have_content("Enter New Mean Temperature:")
    expect(page).to have_content("Enter New Low Temperature:")
    expect(page).to have_content("Enter New Mean Humidity:")
    expect(page).to have_content("Enter New Mean Visibility (in miles):")
    expect(page).to have_content("Enter New Mean Wind Speed (in mph):")
    expect(page).to have_content("Enter New Precipitation Total (in inches):")
  end
end
