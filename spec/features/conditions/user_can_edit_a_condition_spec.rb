# describe "User visits condition edit page" do
#   before :each do
#     date1 = DateTime.new(2017, 10, 8)
#     date2 = DateTime.new(2017, 10, 7)
#     @trip_1 = Trip.create(duration: 12, start_date: date2, start_station_id: 1, end_date: date1, end_station_id: 2, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345', condition_id: 1)
#     @trip_2 = Trip.create(duration: 120, start_date: date1, start_station_id: 2, end_date: date1, end_station_id: 2, bike_id: 3, subscription_type: 'Customer', zip_code: '12345', condition_id: 2)
#     @trip_3 = Trip.create(duration: 120, start_date: date1, start_station_id: 2, end_date: date2, end_station_id: 2, bike_id: 1, subscription_type: 'Customer', zip_code: '12345', condition_id: 2)
#     @station_1 = Station.create(installation_date: date1, dock_count: 4, name: 'Humberto', city: 'Place')
#     @station_2 = Station.create(installation_date: date1, dock_count: 4, name: 'Walter', city: 'Different Place')
#     @condition_1 = Condition.create(date: date1, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
#     @condition_2 = Condition.create(date: date2, max_temperature: 60, mean_temperature: 40, min_temperature: 20, mean_humidity: 25, mean_visibility: 5, mean_wind_speed: 6, precipitation: 0.4)
#   end

#   it "they see the edit condition form" do
#     visit "conditions/#{@condition_1.id}/edit"

#     expect(page).to have_content("change trip condition details")
#     expect(page).to have_content("Date:")
#     expect(page).to have_content("High Temperature:")
#     expect(page).to have_content("Mean Temperature:")
#     expect(page).to have_content("Low Temperature:")
#     expect(page).to have_content("Mean Humidity:")
#     expect(page).to have_content("Mean Visibility (in miles):")
#     expect(page).to have_content("Mean Wind Speed (in mph):")
#     expect(page).to have_content("Precipitation Total (in inches):")
#   end

#   it "they can edit the condition" do
#     visit "/conditions/#{@condition_1.id}/edit"

#     fill_in("condition[date]", with: "2011-11-11")
#     fill_in("condition[max_temperature]", with: '99')
#     fill_in("condition[mean_temperature]", with: '49')
#     fill_in("condition[min_temperature]", with: '-1')
#     fill_in("condition[mean_humidity]", with: '75')
#     fill_in("condition[mean_visibility]", with: '9')
#     fill_in("condition[mean_wind_speed]", with: '10')
#     fill_in("condition[precipitation]", with: '0.1')

#     click_on("Save Changes")

#     expect(current_path).to eq("/conditions/#{@condition_1.id}")

#     expect(page).to have_content("2011-11-11")
#     expect(page).to have_content("99")
#     expect(page).to have_content("49")
#     expect(page).to have_content("-1")
#     expect(page).to have_content("75")
#     expect(page).to have_content("9")
#     expect(page).to have_content("10")
#     expect(page).to have_content("0.1")
#   end
# end
