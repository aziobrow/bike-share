describe "when a user visits a station's edit page" do

  before :each do
    date = DateTime.now
    @station = Station.create(installation_date: date, dock_count: 4, name: 'Humberto', city: 'Place')
  end

  it "renders an edit form" do

    visit "/stations/#{@station.id}/edit"

    expect(page).to have_content("Enter New Installation Date")
    expect(page).to have_content("Enter New Dock Count:")
    expect(page).to have_content("Enter New City:")
    expect(page).to have_content("Enter New Station Name:")
  end

  it "renders the current values of the station in the textareas" do

    visit "/stations/#{@station.id}/edit"

    expect(find_field('station[name]').value).to eq('Humberto')
    expect(find_field('station[dock_count]').value).to eq('4')
    expect(find_field('station[city]').value).to eq('Place')
    expect(find_field('station[installation_date]').value).to include('2017')
  end

  it "takes the user back to the station show page after clicking save changes" do

    visit "/stations/#{@station.id}/edit"
    fill_in('station[name]', with: 'Muffins')
    click_button('Save Changes')

    expect(current_path).to eq("/stations/#{@station.id}")
    expect(page).to have_content('Muffins')
    expect(page).not_to have_content('Humberto')
  end

  it "takes the user back to the station show page after clicking back to station link" do

    visit "/stations/#{@station.id}/edit"
    fill_in('station[name]', with: 'Muffins')
    click_link('Back to Station')

    expect(current_path).to eq("/stations/#{@station.id}")
    expect(page).not_to have_content('Muffins')
    expect(page).to have_content('Humberto')
  end

end
