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
  
  describe 'Class Methods' do
    before :each do
      date_1 = DateTime.now
      date_2 = DateTime.new(2017,4,5,6)
      Station.create(installation_date: date_2, dock_count: 4, name: 'Ralph', city: 'Place', original_station_id: 1)
      Station.create(installation_date: date_2, dock_count: 10, name: 'Humberto', city: 'Different Place', original_station_id: 2)
      Trip.create(duration: 20, start_date: date_2, start_station_id: 1, end_date: date_1, end_station_id: 2, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345', condition_id: 1, original_station_id: 1)
      Trip.create(duration: 10, start_date: date_2, start_station_id: 1, end_date: date_1, end_station_id: 2, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345', condition_id: 1, original_station_id: 1)
      Condition.create(date: date_1, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
      Condition.create(date: date_2, max_temperature: 60, mean_temperature: 40, min_temperature: 20, mean_humidity: 25, mean_visibility: 5, mean_wind_speed: 6, precipitation: 0.4)
    end

    it '.most_frequent_station' do
      expect(Trip.most_frequent_station(:original_station_id, "ASC")).to eq("Ralph")
      expect(Trip.most_frequent_station(:original_station_id, "DESC")).to eq("Ralph")
    end

    it '.average_duration_of_a_ride' do
      expect(Trip.average_duration_of_a_ride).to eq(15)
    end

    it '.longest_ride' do
      expect(Trip.longest_ride).to eq(20)
    end

    it '.shortest_ride' do
      expect(Trip.shortest_ride).to eq(10)
    end

    it '.find_min_or_max' do
      expect(Trip.find_min_or_max(:duration, "ASC")).to eq({20=>1, 10=>1})
    end

    # it '.bike_analytics' do
    #   expect(Trip.bike_analytics).to eq({3=>2})
    # end

    it '.subscription_breakdown' do
      expect(Trip.subscription_breakdown).to eq([2])
    end

    it '.find_user_count_for_subscription_type' do
      expect(Trip.find_user_count_for_subscription_type("Subscriber")).to eq(2)
    end

    it '.calculate_percentage' do
      expect(Trip.calculate_percentage("Subscriber")).to eq(100)
    end

    it '#display_monthly_rides' do
      expect(Trip.display_monthly_rides("2014")).to eq(["April"])
    end

  end

  describe 'Instance Methods' do
    before :each do
      date_1 = DateTime.now
      date_2 = DateTime.new(2017,4,5,6)
      @station_1 = Station.create(installation_date: date_2, dock_count: 4, name: 'Ralph', city: 'Place', original_station_id: 1)
      @station_2 = Station.create(installation_date: date_2, dock_count: 10, name: 'Humberto', city: 'Different Place', original_station_id: 2)
      @trip_1 = Trip.create(duration: 20, start_date: date_2, start_station_id: @station_1.original_station_id, end_date: date_1, end_station_id: @station_2.original_station_id, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345', original_station_id: 1)
      @trip_2 = Trip.create(duration: 10, start_date: date_2, start_station_id: @station_1.original_station_id, end_date: date_1, end_station_id: @station_2.original_station_id, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345', original_station_id: 1)
      @condition_1 = Condition.create(date: date_1, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
      @condition_2 = Condition.create(date: date_2, max_temperature: 60, mean_temperature: 40, min_temperature: 20, mean_humidity: 25, mean_visibility: 5, mean_wind_speed: 6, precipitation: 0.4)
    end

    it '#starting_station_name' do
      expect(@trip_2.starting_station_name).to eq('Ralph')
      expect(@trip_1.starting_station_name).to eq('Ralph')
    end

    it '#ending_station_name' do
      expect(@trip_1.ending_station_name).to eq('Humberto')
      expect(@trip_2.ending_station_name).to eq('Humberto')
    end

    it '#number_of_rides_per_time_period' do
      expect(Trip.number_of_rides_per_time_period("year", "2017")).to eq(2)
    end
  end
end
