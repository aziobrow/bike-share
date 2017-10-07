describe 'when a user visits the station dashboard page' do

  before :each do
    date_1 = DateTime.now
    date_2 = DateTime.new(2001,4,5,6,7)
    @station_1 = Station.create(installation_date: date_1, dock_count: 4, name: 'Ralph', city: 'Place')
    @station_2 = Station.create(installation_date: date_2, dock_count: 10, name: 'Humberto', city: 'Different Place')
  end

  it 'renders a page with station analytics' do

    visit "/stations-dashboard"

    expect(page).to have_content("Total Number of Stations: 2")
    expect(page).to have_content("Average Number of Bikes Per Station: 7")
    expect(page).to have_content("Most Bikes Available: 10")
    expect(page).to have_content("Stations with Most Bikes Available: Humberto")
    expect(page).to have_content("Fewest Bikes Available: 4")
    expect(page).to have_content("Stations with Fewest Bikes Available: Ralph")
    expect(page).to have_content("Newest Station: Ralph")
    expect(page).to have_content("Oldest Station: Humberto")
  end
end
