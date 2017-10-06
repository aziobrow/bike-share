describe "when a user visits '/stations/new'" do

  it "renders a new station form" do

    visit "/stations/new"

    expect(page).to have_content("Enter a new station:")
    expect(page).to have_content("Name:")
    expect(page).to have_content("Number of Docks:")
    expect(page).to have_content("City:")
    expect(page).to have_content("Installation Date:")
  end

  # it "takes the user back to the station index page after clicking create station" do
  #
  #   visit "/stations/new"
  #   fill_in('station[name]', with: 'Muffins')
  #   fill_in('station[city]', with: 'Blueberry')
  #   fill_in('station[dock_count]', with: '4')
  #   fill_in('station[installation_date]', with: '3/29/2009')
  #
  #   click_button('Create Station')
  #   save_and_open_page
  #
  #   expect(current_path).to eq("/stations")
  #   # expect(page).to have_content('Muffins')
  #   expect(page).to have_content('Blueberry')
  # end

end
