describe "User can delete a station" do

  before :each do
    date = DateTime.now
    @station = Station.create(installation_date: date, dock_count: 4, name: 'Humberto', city: 'Place')
  end

  it "can delete it from index page" do

    visit "/stations"

    expect(page).to have_content('Humberto')
    expect(page).to have_content('Place')

    click_on("Delete")

    expect(page).to_not have_content('Humberto')
    expect(page).to_not have_content('Place')
  end

  it "can delete it from show page" do

    visit "/stations/#{@station.id}"

    expect(page).to have_content('Humberto')
    expect(page).to have_content('4')
    expect(page).to have_content('Place')
    expect(page).to have_content('2017')

    click_on("Delete")

    expect(current_path).to eq("/stations")

    expect(page).to_not have_content('Humberto')
    expect(page).to_not have_content('Place')
  end

end
