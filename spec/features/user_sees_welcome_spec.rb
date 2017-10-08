RSpec.describe "When a user visits the homepage" do
  it "they see a station index" do
    visit '/'

    expect(page).to have_content('stations')
    expect(page).to have_content('trips')
    expect(page).to have_content('bike share')
  end

end
