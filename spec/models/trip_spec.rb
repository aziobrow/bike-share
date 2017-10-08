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

  describe 'instance methods' do
    before :each do
      date1 = DateTime.now
      date2 = DateTime.new(2008,2,3,4,5)
      @trip_1 = Trip.create(duration: 12, start_date: date2, start_station_id: 1, end_date: date1, end_station_id: 2, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345')
      @trip_2 = Trip.create(duration: 120, start_date: date2, start_station_id: 2, end_date: date1, end_station_id: 2, bike_id: 4, subscription_type: 'Subscriber', zip_code: '12345')
      date_1 = DateTime.now
      date_2 = DateTime.new(2001,4,5,6,7)
      @station_1 = Station.create(installation_date: date_1, dock_count: 4, name: 'Ralph', city: 'Place')
      @station_2 = Station.create(installation_date: date_2, dock_count: 10, name: 'Humberto', city: 'Different Place')

    end

    it '#starting_station_name' do
      expect(@trip_1.starting_station_name).to eq('Ralph')
      expect(@trip_2.starting_station_name).to eq('Humberto')
    end

    it '#ending_station_name' do
      expect(@trip_1.ending_station_name).to eq('Humberto')
      expect(@trip_2.ending_station_name).to eq('Humberto')
    end

    it '#calulate_duration when duration exists' do
      expect(@trip_1.calculate_duration).to eq(0)
      expect(@trip_2.calculate_duration).to eq(2)
    end

    it '#calulate_duration from start and end date' do
      date1 = DateTime.now
      date2 = DateTime.now - 120
      @trip_1 = Trip.create(start_date: date2, start_station_id: 1, end_date: date1, end_station_id: 2, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345')

      expect(@trip_1.calculate_duration).to eq(2)
    end

  end
end
