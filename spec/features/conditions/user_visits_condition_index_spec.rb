describe "User visits condition index page" do
  before :each do
    date = DateTime.new(2010, 10, 10)
    date2 = DateTime.new(2010, 10, 11)
    @condition_1 = Condition.create(date: date, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
    @condition_2 = Condition.create(date: date2, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
  end

  it "they see a list of conditions by date" do
    visit "/conditions"

    expect(page).to have_content("2010-10-10")
    expect(page).to have_content("2010-10-11")
  end
end
