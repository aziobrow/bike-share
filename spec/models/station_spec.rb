RSpec.describe Station do
  describe 'Validations' do
    it 'is invalid without a name' do
      date = DateTime.now
      station = Station.new(city: 'Place', dock_count: 4, installation_date: date)

      expect(station).to_not be_valid
    end
  end
end
