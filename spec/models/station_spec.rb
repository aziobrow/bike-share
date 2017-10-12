RSpec.describe Station do
  describe 'Validations' do
    it 'is invalid without a name' do
      date = DateTime.now
      station = Station.new(city: 'Place', dock_count: 4, installation_date: date)

      expect(station).to_not be_valid
    end

    it 'is invalid without a dock count' do
      date = DateTime.now
      station = Station.new(city: 'Place', name: 'Humberto', installation_date: date)

      expect(station).to_not be_valid
    end

    it 'is invalid without a city' do
      date = DateTime.now
      station = Station.new(dock_count: 4, name: 'Humberto', installation_date: date)

      expect(station).to_not be_valid
    end

    it 'is invalid without a installation_date' do
      station = Station.new(dock_count: 4, name: 'Humberto', city: 'Place')

      expect(station).to_not be_valid
    end

    it 'is valid with all attributes' do
      date = DateTime.now
      station = Station.new(installation_date: date, dock_count: 4, name: 'Humberto', city: 'Place')

      expect(station).to be_valid
    end
  end

  describe 'Class Methods' do
    before :each do
      date_1 = DateTime.now
      date_2 = DateTime.new(2001,4,5,6,7)
      Station.create(installation_date: date_1, dock_count: 4, name: 'Ralph', city: 'Place')
      Station.create(installation_date: date_2, dock_count: 10, name: 'Humberto', city: 'Different Place')
    end

    it '.mean_number_of_bikes' do
      expect(Station.mean_number_of_bikes).to eq(7)
    end

    it '.max_number_of_bikes' do
      expect(Station.max_number_of_bikes).to eq(10)
    end

    it '.min_number_of_bikes' do
      expect(Station.min_number_of_bikes).to eq(4)
    end

    it '.station_with_max_bikes' do
      expect(Station.station_with_max_bikes.first.name).to eq("Humberto")
    end

    it '.station_with_min_bikes' do
      expect(Station.station_with_min_bikes.first.name).to eq("Ralph")
    end

    it '.most_recently_installed_station' do
      expect(Station.most_recently_installed_station.name).to eq("Ralph")
    end

    it '.oldest_station' do
      expect(Station.oldest_station.name).to eq("Humberto")
    end
  end

  describe "Instance Methods" do
    before :each do
      date_1 = DateTime.now
      date_2 = DateTime.new(2017,4,5,6)
      @station_1 = Station.create(installation_date: date_2, dock_count: 4, name: 'Ralph', city: 'Place', station_id: 1)
      @station_2 = Station.create(installation_date: date_2, dock_count: 10, name: 'Humberto', city: 'Different Place', station_id: 2)
      @trip_1 = Trip.create(duration: 20, start_date: date_2, start_station_id: @station_1.station_id, end_date: date_1, end_station_id: @station_2.station_id, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345')
      @trip_2 = Trip.create(duration: 10, start_date: date_2, start_station_id: @station_1.station_id, end_date: date_1, end_station_id: @station_2.station_id, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345')
      @condition_1 = Condition.create(date: date_1, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
      @condition_2 = Condition.create(date: date_2, max_temperature: 60, mean_temperature: 40, min_temperature: 20, mean_humidity: 25, mean_visibility: 5, mean_wind_speed: 6, precipitation: 0.4)
    end

    it '#count_rides_started_at_station' do
      expect(@station_1.count_rides_started_at_station).to eq(2)
      expect(@station_2.count_rides_started_at_station).to eq(0)
    end

    it '#count_rides_ended_at_station' do
      expect(@station_2.count_rides_ended_at_station).to eq(2)
      expect(@station_1.count_rides_ended_at_station).to eq(0)
    end

    it '#most_frequent_destination' do
      expect(@station_2.most_frequent_destination).to eq("No trips are associated with this station.")
      expect(@station_1.most_frequent_destination).to eq("Humberto")
    end

    it '#most_frequent_origin' do
      expect(@station_2.most_frequent_origin).to eq("Ralph")
      expect(@station_1.most_frequent_origin).to eq("No trips are associated with this station.")
    end

    it '#date_with_most_trips' do
      expect(@station_1.date_with_most_trips).to eq(Date.new(2017,4,5,6))
      expect(@station_2.date_with_most_trips).to eq(nil)
    end

    it '#most_frequent_starting_zip_code' do
      expect(@station_1.most_frequent_starting_zip_code).to eq("12345")
      expect(@station_2.most_frequent_starting_zip_code).to eq(nil)
    end

    it '#most_frequent_starting_bike' do
      expect(@station_1.most_frequent_starting_bike).to eq(3)
      expect(@station_2.most_frequent_starting_bike).to eq(nil)
    end
  end
end
