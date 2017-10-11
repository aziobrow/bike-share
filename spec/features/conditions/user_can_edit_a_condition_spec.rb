describe "User visits condition edit page" do
  before :each do
    date = DateTime.new(2010, 10, 10)
    @condition1 = Condition.new(date: date, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
  end

  it "they can edit the condition" do
    visit "/conditions/#{@condition1.id}/edit"

    fill_in("condition[date]", with: "2011-11-11")
    fill_in("condition[max_temperature]", with: '99')
    fill_in("condition[mean_temperature]", with: '49')
    fill_in("condition[min_temperature]", with: '-1')
    fill_in("condition[mean_humidity]", with: '75')
    fill_in("condition[mean_visibility]", with: '9')
    fill_in("condition[mean_wind_speed]", with: '10')
    fill_in("condition[precipitation]", with: '0.1')

    click_on("Save Changes")

    expect(current_path).to eq("/conditions/#{@condition1.id}")

    expect(page).to have_content("2011-11-11")
    expect(page).to have_content("99")
    expect(page).to have_content("49")
    expect(page).to have_content("-1")
    expect(page).to have_content("75")
    expect(page).to have_content("9")
    expect(page).to have_content("10")
    expect(page).to have_content("0.1")
  end
end
