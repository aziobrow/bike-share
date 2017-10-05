describe "when a user visits '/stations'" do

  it "they see station names and cities" do
  date = DateTime.now
  station = Station.create(installation_date: date, dock_count: 4, name: 'Humberto', city: 'Place')
  station = Station.create(installation_date: date, dock_count: 3, name: 'Hurto', city: 'here')

  visit '/stations'

  save_and_open_page

  expect(page).to have_content("Humberto")
  expect(page).to have_content("Hurto")
  expect(page).to have_content("Place")
  expect(page).to have_content("here")
  end

end
