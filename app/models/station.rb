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

  def self.most_frequent_destination
    joins(:ended_trips)
      .select("count(trips.end_station_id) AS end_station_counts, stations.*")
      .group("stations.id")
      .order("end_station_counts DESC")
      .first
      .name
  end

  def self.most_frequent_origin_station
    joins(:started_trips)
      .select("count(trips.start_station_id) AS start_station_counts, stations.*")
      .group("stations.id")
      .order("start_station_counts DESC")
      .first
      .name
  end

  def date_with_most_trips
    started_trips
      .order("start_date")
      .first
      .start_date
  end

  # def date_with_most_trips
  #   Trip.where(start_station_id: self.station_id).group(:start_date).order("count_id DESC").limit(1).count(:id).keys.first
  # end

  def most_frequent_starting_zip_code
    Trip.where(start_station_id: self.station_id).group(:zip_code).order("count_id DESC").limit(1).count(:id).keys.first
  end

  def most_frequent_starting_bike
    Trip.where(start_station_id: self.station_id).group(:bike_id).order("count_id DESC").limit(1).count(:id).keys.first
  end

end
