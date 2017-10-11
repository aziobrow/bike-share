describe "User visits condition edit page" do
  before :each do
    date = DateTime.new(2010, 10, 10)
    date2 = DateTime.new(2010, 10, 11)
    @condition1 = Condition.create(date: date, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
    @condition2 = Condition.create(date: date2, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
  end

  it "they see the edit condition form" do
    visit "conditions/#{@condition1.id}/edit"
    save_and_open_page
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
