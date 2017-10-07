require 'pry'
class Trip < ActiveRecord::Base
  belongs_to :station
  validates :duration, presence: true
  validates :start_date, presence: true
  validates :start_station_id, presence: true
  validates :end_date, presence: true
  validates :end_station_id, presence: true
  validates :bike_id, presence: true
  validates :subscription_type, presence: true

  def starting_station_name
    station = Station.find(self.start_station_id)
    station.name
  end

  def ending_station_name
    station = Station.find(self.end_station_id)
    station.name
  end

  def calculate_duration
    duration = self.end_date - self.start_date
    (duration / 60).to_i
  end
end
