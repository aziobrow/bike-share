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
end
