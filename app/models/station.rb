class Station < ActiveRecord::Base
  has_many :trips
  validates :name, presence: true
  validates :city, presence: true
  validates :dock_count, presence: true
  validates :installation_date, presence: true

  def mean_number_of_bikes
    Station.average(:dock_count)
  end

  def max_number_of_bikes
    Station.maximum(:dock_count)
  end

  def station_with_max_bikes
    Station.all.select do |station|
      station.dock_count == max_number_of_bikes
    end
  end

  def min_number_of_bikes
    Station.minimum(:dock_count)
  end

  def station_with_min_bikes
    Station.all.select do |station|
      station.dock_count == min_number_of_bikes
    end
  end

  def most_recently_installed_station
    Station.order(:installation_date).last
  end

  def oldest_station
    Station.order(:installation_date).first
  end

  def count_rides_started_at_station
    station_counts = Trip.group(:start_station_id).count
    if station_counts.keys.include?(self.station_id)
      station_counts[self.station_id]
    else
      0
    end
  end

  def count_rides_ended_at_station
    station_counts = Trip.group(:end_station_id).count
    if station_counts.keys.include?(self.station_id)
      station_counts[self.station_id]
    else
      0
    end
  end

  def most_frequent_destination
    end_station_id = Trip.where(start_station_id: self.station_id).group(:end_station_id).order("count_id DESC").limit(1).count(:id).keys.first
    if !end_station_id.nil?
      Station.find(end_station_id).name
    else
      "No trips are associated with this station."
    end
  end

  def most_frequent_origin
    start_station_id = Trip.where(end_station_id: self.station_id).group(:start_station_id).order("count_id DESC").limit(1).count(:id).keys.first
    if !start_station_id.nil?
      Station.find(start_station_id).name
    else
      "No trips are associated with this station."
    end
  end

  def date_with_most_trips
    Trip.where(start_station_id: self.station_id).group(:start_date).order("count_id DESC").limit(1).count(:id).keys.first
  end

  def most_frequent_starting_zip_code
    Trip.where(start_station_id: self.station_id).group(:zip_code).order("count_id DESC").limit(1).count(:id).keys.first
  end

  def most_frequent_starting_bike
    Trip.where(start_station_id: self.station_id).group(:bike_id).order("count_id DESC").limit(1).count(:id).keys.first
  end

end
