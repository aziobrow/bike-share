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
end
