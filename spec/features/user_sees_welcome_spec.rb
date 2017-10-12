RSpec.describe "When a user visits the homepage" do
  it "they see a station index" do
    visit '/'

    expect(page).to have_content('bike share')
    expect(page).to have_content('home')
    expect(page).to have_content('stations')
    expect(page).to have_content('trips')
    expect(page).to have_content('weather conditions')
    expect(page).to have_content('stations dashboard')
    expect(page).to have_content('trips dashboard')
    expect(page).to have_content('weather dashboard')
    expect(page).to have_content('add a new...')
  end
end
