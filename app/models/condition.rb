class Condition < ActiveRecord::Base
  has_many :trips
  validates :date, presence: true
  validates :max_temperature, presence: true
  validates :mean_temperature, presence: true
  validates :min_temperature, presence: true
  validates :mean_humidity, presence: true
  validates :mean_visibility, presence: true
  validates :mean_wind_speed, presence: true
  validates :precipitation, presence: true

  def self.find_condition_id(date)
    date = Date.strptime(date, "%m/%d/%Y")
    find_by(date: date).id
  end

  def self.find_highest_max_temp
    maximum(:max_temperature)
    .round(-1)
  end

  def self.find_max_precipitation
    max = maximum(:precipitation)
    if max.round > max
      max.round - 0.5
    else
      max.round + 0.5
    end
  end

  def self.find_lowest_max_temp
    minimum(:max_temperature)
    .floor(-1)
  end

  def self.find_max_wind_speed
    maximum(:mean_wind_speed)
  end

  def self.find_max_visibility
    maximum(:mean_visibility)
  end

  def self.collect_ranges(range_floor, range_ceiling, range_increment, floor_increment)
    range_values = []
    until range_floor >= range_ceiling
      range_values << "#{range_floor} - #{range_floor + range_increment}: "
      range_floor += floor_increment
    end
    range_values
  end

  def self.collect_max_temp_ranges
    range_floor = find_lowest_max_temp
    range_ceiling = find_highest_max_temp
    collect_ranges(range_floor, range_ceiling, 9, 10)
  end

  def self.collect_max_precipitation_ranges
    range_floor = 0
    range_ceiling = find_max_precipitation
    collect_ranges(range_floor, range_ceiling, 0.49, 0.5)
  end

  def self.collect_max_visibility_range
    range_floor = 0
    range_ceiling = find_max_visibility
    collect_ranges(range_floor, range_ceiling, 3.99, 4)
  end

  def self.collect_max_wind_speed_range
    range_floor = 0
    range_ceiling = find_max_wind_speed
    collect_ranges(range_floor, range_ceiling, 3.99, 4)
  end

  def self.find_trip_average_for_given_range(range_floor, column, increment)
    total_trips =
    where("? <= #{column} AND ? > #{column}", range_floor, range_floor + increment)
      .joins(:trips)
      .count

    return 0 if total_trips == 0

    number_of_conditions = range_search(column, range_floor, increment).count
    total_trips / number_of_conditions
  end

  def self.range_search(column, range_floor, increment)
    where("? <= #{column} AND ? >= #{column}", range_floor, range_floor + increment)
  end

  def self.no_conditions_in_range?(conditions_in_range)
    return true if conditions_in_range.empty?
    false
  end

  def self.conditions_from_join_query_for_trips_by_range(range_floor, column, increment, asc_or_desc)
    conditions_in_range =
    where("? <= #{column} AND ? >= #{column}", range_floor, range_floor + increment)

    return 0 if no_conditions_in_range?(conditions_in_range)

    conditions_in_range
      joins(:trips)
      .select("count(trips.id) AS trip_count, conditions.id")
      .group("conditions.id")
      .order("trip_count #{asc_or_desc}")
      .first
      .trip_count
  end

  def self.collect_descriptors_for_range(range_floor, range_ceiling, column, increment)
    all_descriptors = []
    until range_floor > range_ceiling
      range_descriptors = []
      range_descriptors << find_trip_average_for_given_range(range_floor, column, increment)
      range_descriptors << conditions_from_join_query_for_trips_by_range(range_floor, column, increment, "DESC")
      range_descriptors << conditions_from_join_query_for_trips_by_range(range_floor, column, increment, "ASC")
      all_descriptors << range_descriptors
      range_floor += increment
    end
    all_descriptors
  end

  def self.collect_descriptors_for_each_ten_degree_temp_range
    range_floor = find_lowest_max_temp
    range_ceiling = find_highest_max_temp
    require "pry"; binding.pry
    collect_descriptors_for_range(range_floor, range_ceiling, "max_temperature", 10)
  end


  def self.collect_descriptors_for_each_precipitation_range
    range_floor = 0
    range_ceiling = find_max_precipitation
    collect_descriptors_for_range(range_floor, range_ceiling, "precipitation", 0.5)
  end

  def self.collect_descriptors_for_each_mean_wind_speed_range
    range_floor = 0
    range_ceiling = find_max_wind_speed
    collect_descriptors_for_range(range_floor, range_ceiling, "mean_wind_speed", 4)
  end

  def self.collect_descriptors_for_each_mean_visibility_range
    range_floor = 0
    range_ceiling = find_max_visibility
    collect_descriptors_for_range(range_floor, range_ceiling, "mean_visibility", 4)
  end

  def self.find_condition_with_most_or_least_trips(asc_or_desc)
    retrieve_trip_count_from_join_query(asc_or_desc)
      .first
  end

end
