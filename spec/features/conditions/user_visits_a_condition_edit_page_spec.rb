describe "User visits condition edit page" do
  before :each do
    date1 = DateTime.new(2017, 10, 8)
    @condition_1 = Condition.create(date: date1, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
  end

  it "they see the edit condition form" do
    visit "conditions/#{@condition_1.id}/edit"

    expect(page).to have_content("change trip condition details")
    expect(page).to have_content("Date:")
    expect(page).to have_content("High Temperature:")
    expect(page).to have_content("Mean Temperature:")
    expect(page).to have_content("Low Temperature:")
    expect(page).to have_content("Mean Humidity:")
    expect(page).to have_content("Mean Visibility (in miles):")
    expect(page).to have_content("Mean Wind Speed (in mph):")
    expect(page).to have_content("Precipitation Total (in inches):")
  end
end
