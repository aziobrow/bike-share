RSpec.describe Condition do
  describe 'Validations' do
    it 'is invalid without a date' do
      date = DateTime.now
      condition = Condition.new(max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)

      expect(condition).to_not be_valid
    end

    it 'is invalid without a max_temperature' do
      date = DateTime.now
      condition = Condition.new(date: date, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)

      expect(condition).to_not be_valid
    end

    it 'is invalid without a mean_temperature' do
      date = DateTime.now
      condition = Condition.new(date: date, max_temperature: 100, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)

      expect(condition).to_not be_valid
    end

    it 'is invalid without a min_temperature' do
      date = DateTime.now
      condition = Condition.new(date: date, max_temperature: 100, mean_temperature: 50, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)

      expect(condition).to_not be_valid
    end

    it 'is invalid without a mean_humidity' do
      date = DateTime.now
      condition = Condition.new(date: date, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)

      expect(condition).to_not be_valid
    end


    it 'is invalid without a mean_visibility' do
      date = DateTime.now
      condition = Condition.new(date: date, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_wind_speed: 11, precipitation: 0.2)

      expect(condition).to_not be_valid
    end

    it 'is invalid without a mean_wind_speed' do
      date = DateTime.now
      condition = Condition.new(date: date, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, precipitation: 0.2)

      expect(condition).to_not be_valid
    end

    it 'is invalid without precipitation' do
      date = DateTime.now
      condition = Condition.new(date: date, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11)

      expect(condition).to be_invalid
    end

    it 'is valid with all attributes' do
      date = DateTime.now
      condition = Condition.new(date: date, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)

      expect(condition).to be_valid
    end
  end

  describe 'Class Methods' do
    before :each do
      date_1 = DateTime.now
      date_2 = DateTime.new(2017,4,5,6)
      Trip.create(duration: 20, start_date: date_2, start_station_id: 1, end_date: date_1, end_station_id: 2, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345', condition_id: 1)
      Trip.create(duration: 10, start_date: date_2, start_station_id: 1, end_date: date_1, end_station_id: 2, bike_id: 3, subscription_type: 'Subscriber', zip_code: '12345', condition_id: 1)
      Condition.create(date: date_1, max_temperature: 100, mean_temperature: 50, min_temperature: 0, mean_humidity: 50, mean_visibility: 10, mean_wind_speed: 11, precipitation: 0.2)
      Condition.create(date: date_2, max_temperature: 60, mean_temperature: 40, min_temperature: 20, mean_humidity: 25, mean_visibility: 5, mean_wind_speed: 6, precipitation: 0.4)
      Station.create(installation_date: date_1, dock_count: 4, name: 'Ralph', city: 'Place')
      Station.create(installation_date: date_2, dock_count: 10, name: 'Humberto', city: 'Different Place')
    end

    it '.find_higest_max_temp' do
      expect(Condition.find_highest_max_temp).to eq(100)
    end

    it '.find_max_precipitation' do
      expect(Condition.find_max_precipitation).to eq(0.5)
    end

    it '.find_lowest_max_temp' do
      expect(Condition.find_lowest_max_temp).to eq(60)
    end

    it '.find_max_wind_speed' do
      expect(Condition.find_max_wind_speed).to eq(11)
    end

    it '.find_max_visibility' do
      expect(Condition.find_max_visibility).to eq(10)
    end

    it '.collect_max_temp_ranges' do
      expect(Condition.collect_max_temp_ranges).to eq(["60 - 69: ", "70 - 79: ", "80 - 89: ", "90 - 99: "])
    end

    it '.collect_max_precipitation_ranges' do
      expect(Condition.collect_max_precipitation_ranges).to eq(["0 - 0.49: "])
    end

    it '.collect_max_visibility_range' do
      expect(Condition.collect_max_visibility_range).to eq(["0 - 3.99: ", "4 - 7.99: ", "8 - 11.99: "])
    end

    it '.collect_max_wind_speed_range' do
      expect(Condition.collect_max_wind_speed_range).to eq(["0 - 3.99: ", "4 - 7.99: ", "8 - 11.99: "])
    end

    it '.find_trip_average_for_given_range' do
      expect(Condition.find_trip_average_for_given_range(10, :mean_wind_speed, 10)).to eq(2)
    end

    it '.conditions_from_join_query_for_trips_by_range' do
      expect(Condition.conditions_from_join_query_for_trips_by_range(0, :min_temperature, 10, "ASC")).to eq(2)
    end

    it '.collect_descriptors_for_range' do
      expect(Condition.collect_descriptors_for_range(0, 100, :mean_temperature, 10)).to eq( [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 2, 2], [0, 2, 2], [2, 2, 2], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]])
    end

    it '.collect_descriptors_for_each_ten_degree_temp_range' do
      expect(Condition.collect_descriptors_for_each_ten_degree_temp_range).to eq([[0, 2, 2], [0, 0, 0], [0, 0, 0], [0, 2, 2], [2, 2, 2]])
    end

    it '.collect_descriptors_for_each_precipitation_range' do
      expect(Condition.collect_descriptors_for_each_precipitation_range).to eq([[1, 2, 2], [0, 0, 0]])
    end

    it '.collect_descriptors_for_each_mean_wind_speed_range' do
      expect(Condition.collect_descriptors_for_each_mean_wind_speed_range).to eq([[0, 0, 0], [0, 2, 2], [2, 2, 2]])
    end

    it '.collect_descriptors_for_each_mean_visibility_range' do
      expect(Condition.collect_descriptors_for_each_mean_visibility_range).to eq([[0, 0, 0], [0, 2, 2], [2, 2, 2]])
    end

    it '.find_condition_with_most_trips' do
      expect(Condition.find_condition_with_most_or_least_trips("DESC")).to eq(Condition.first)
    end

    it '.find_condition_with_least_trips' do
      expect(Condition.find_condition_with_most_or_least_trips("ASC")).to eq(Condition.first)
    end
  end
end
