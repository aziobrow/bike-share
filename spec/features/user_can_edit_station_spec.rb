describe "when a user visits '/stations/:id/edit'" do

  it "they see an edit form" do
    date = DateTime.now
    station = Station.create(installation_date: date, dock_count: 4, name: 'Humberto', city: 'Place')

    visit "/stations/#{station.id}/edit"

    expect(page).to have_content("Enter New Installation Date")
    expect(page).to have_content("Enter New Dock Count:")
    expect(page).to have_content("Enter New City:")
    expect(page).to have_content("Enter New Station Name:")
  end

  it "they see the current values of the station in the textareas" do
    date = DateTime.now
    station = Station.create(installation_date: date, dock_count: 4, name: 'Humberto', city: 'Place')

    visit "/stations/#{station.id}/edit"

    expect(find_field('station[name]').value).to eq('Humberto')
    # expect(page).to have_content("Place")
    # expect(page).to have_content("4")
    # expect(page).to have_content(date)
  end



end
