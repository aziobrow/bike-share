RSpec.describe Trip do
  describe 'Validations' do
    it 'is invalid without a duration' do
      date1 = DateTime.now
      date2 = DateTime.new(2008,2,3,4,5)
      trip = Trip.new(start_date: date2, start_station_id: 3, end_date: date1, end_station_id: 12, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345')

      expect(trip).to_not be_valid
    end

    it 'is invalid without a start date' do
      date1 = DateTime.now
      trip = Trip.new(duration: 12334, start_station_id: 3, end_date: date1, end_station_id: 12, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345')

      expect(trip).to_not be_valid
    end

    it 'is invalid without a start station' do
      date1 = DateTime.now
      date2 = DateTime.new(2008,2,3,4,5)
      trip = Trip.new(duration: 12334, start_date: date2, end_date: date1, end_station_id: 12, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345')

      expect(trip).to_not be_valid
    end

    it 'is invalid without an end date' do
      date2 = DateTime.new(2008,2,3,4,5)
      trip = Trip.new(duration: 12334, start_date: date2, start_station_id: 3, end_station_id: 12, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345')

      expect(trip).to_not be_valid
    end

    it 'is invalid without an end station' do
      date1 = DateTime.now
      date2 = DateTime.new(2008,2,3,4,5)
      trip = Trip.new(duration: 12334, start_date: date2, start_station_id: 3, end_date: date1, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345')

      expect(trip).to_not be_valid
    end


    it 'is invalid without a bike id' do
      date1 = DateTime.now
      date2 = DateTime.new(2008,2,3,4,5)
      trip = Trip.new(duration: 12334, start_date: date2, start_station_id: 3, end_date: date1, end_station_id: 12, subscription_type: 'Subscriber', zip_code: '12345')

      expect(trip).to_not be_valid
    end

    it 'is invalid without a subscription type' do
      date1 = DateTime.now
      date2 = DateTime.new(2008,2,3,4,5)
      trip = Trip.new(duration: 12334, start_date: date2, start_station_id: 3, end_date: date1, end_station_id: 12, bike_id: 3, zip_code: '12345')

      expect(trip).to_not be_valid
    end

    it 'is valid without a zip code' do
      date1 = DateTime.now
      date2 = DateTime.new(2008,2,3,4,5)
      trip = Trip.new(duration: 12334, start_date: date2, start_station_id: 3, end_date: date1, end_station_id: 12, bike_id: 3, subscription_type: 'Subscriber')

      expect(trip).to be_valid
    end

    it 'is valid with all attributes' do
      date1 = DateTime.now
      date2 = DateTime.new(2008,2,3,4,5)
      trip = Trip.new(duration: 12334, start_date: date2, start_station_id: 3, end_date: date1, end_station_id: 12, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345')

      expect(trip).to be_valid
    end
  end
end
