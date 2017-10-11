describe "User visits condition index page" do
  before :each do
    date = DateTime.new(2010, 10, 10)
    date2 = DateTime.new(2010, 10, 11)
    @condition_1 = Condition.create(date: date, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
    @condition_2 = Condition.create(date: date2, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
  end

  it "they see the specific dates condition information" do
    visit "/conditions/#{@condition_1.id}"

    expect(page).to have_content("Viewing Weather for: 2010-10-10")
    expect(page).to have_content("High Temperature: 100")
    expect(page).to have_content("Mean Temperature: 50")
    expect(page).to have_content("Low Temperature: 0")
    expect(page).to have_content("Mean Humidity: 50")
    expect(page).to have_content("Mean Visibility (in miles): 10")
    expect(page).to have_content("Mean Wind Speed (in mph): 11")
    expect(page).to have_content("Precipitation (in inches): 0.2")
  end
end