describe "when a user visits '/stations/:id'" do

  before :each do
    date = DateTime.now
    @station = Station.create(installation_date: date, dock_count: 4, name: 'Humberto', city: 'Place')
  end

  it "renders the current information of station" do

    visit "/stations/#{@station.id}"

    expect(page).to have_content('Humberto')
    expect(page).to have_content('4')
    expect(page).to have_content('Place')
    expect(page).to have_content('2017')
  end

  it "can click link back to station index page" do

    visit("/stations/#{@station.id}")

    click_link("Back to All Stations")

    expect(current_path).to eq("/stations")
  end
end
