describe "when a user visits the new station form page" do

  it "renders a new station form" do

    visit "/stations/new"

    expect(page).to have_content("Enter a new station:")
    expect(page).to have_content("Name:")
    expect(page).to have_content("Number of Docks:")
    expect(page).to have_content("City:")
    expect(page).to have_content("Installation Date:")
  end

  it "takes the user back to the station index page after clicking create station" do

    visit "/stations/new"

    fill_in('station[name]', with: 'Muffins')
    fill_in('station[city]', with: 'Blueberry')
    fill_in('station[dock_count]', with: '4')
    fill_in('station[installation_date]', with: '2013-10-12')
    click_button('Create Station')

    expect(current_path).to eq("/stations")
    expect(page).to have_content('Muffins')
    expect(page).to have_content('Blueberry')
  end

end
