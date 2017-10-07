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

  describe 'Instance Methods' do
    before :each do
      date_1 = DateTime.now
      date_2 = DateTime.new(2001,4,5,6,7)
      @station_1 = Station.create(installation_date: date_1, dock_count: 4, name: 'Ralph', city: 'Place')
      @station_2 = Station.create(installation_date: date_2, dock_count: 10, name: 'Humberto', city: 'Different Place')
    end

    it '#mean_number_of_bikes' do
      expect(@station_1.mean_number_of_bikes).to eq(7)
    end

    it '#max_number_of_bikes' do
      expect(@station_1.max_number_of_bikes).to eq(10)
    end

    it '#min_number_of_bikes' do
      expect(@station_1.min_number_of_bikes).to eq(4)
    end

    it '#station_with_max_bikes' do
      expect(@station_1.station_with_max_bikes.first.name).to eq("Humberto")
    end

    it '#station_with_min_bikes' do
      expect(@station_1.station_with_min_bikes.first.name).to eq("Ralph")
    end

    it '#most_recently_installed_station' do
      expect(@station_1.most_recently_installed_station.name).to eq("Ralph")
    end

    it '#oldest_station' do
      expect(@station_1.oldest_station.name).to eq("Humberto")
    end
  end
end
