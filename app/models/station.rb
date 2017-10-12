class Station < ActiveRecord::Base
  has_many :ended_trips, class_name: "Trip", foreign_key: "end_station_id", primary_key: "original_station_id"
  has_many :started_trips, class_name: "Trip", foreign_key: "start_station_id", primary_key: "original_station_id"
  validates :name, presence: true
  validates :city, presence: true
  validates :dock_count, presence: true
  validates :installation_date, presence: true

  def self.mean_number_of_bikes
    average(:dock_count)
    .round
  end

  def self.max_number_of_bikes
    maximum(:dock_count)
  end

  def self.station_with_max_bikes
    where(dock_count: max_number_of_bikes)
  end

  def self.min_number_of_bikes
    minimum(:dock_count)
  end

  def self.station_with_min_bikes
    where(dock_count: min_number_of_bikes)
  end

  def self.ordered_by_installation_date(asc_or_desc)
    order("installation_date #{asc_or_desc}")
    .first
    .name
  end

  def count_rides_started_at_station
    started_trips
    .count
  end

  def count_rides_ended_at_station
    ended_trips
    .count
  end

  def most_frequent_destination
    id = started_trips
      .group("end_station_id")
      .order("count_id DESC")
      .count(:id)
      .keys
      .first

    Station.find_by(original_station_id: id)
      .name
  end

  def most_frequent_origin
    id = started_trips
      .group("end_station_id")
      .order("count_id DESC")
      .count(:id)
      .keys
      .first

    Station.find_by(original_station_id: id)
      .name
  end

  def most_frequent_x_starting_here(column)
    started_trips
      .group("#{column}")
      .count
      .keys
      .first
  end


end
