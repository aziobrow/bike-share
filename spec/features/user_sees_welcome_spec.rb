RSpec.describe "When a user visits the homepage" do
  it "they see a station index" do
    visit '/'

    expect(page).to have_content('List of Stations')
  end

end
