class Condition < ActiveRecord::Base
  has_many :trips

  def self.find_condition_id(date)
    date = Date.strptime(date, "%m/%d/%Y")
    find_by(date: date).id
  end

  def self.find_highest_max_temp
    maximum(:max_temperature)
    .round(-1)
  end

  def self.find_lowest_max_temp
    minimum(:max_temperature)
    .floor(-1)
  end

  def self.collect_max_temp_ranges
    range_floor = find_lowest_max_temp
    range_ceiling = find_highest_max_temp
    range_values = []
    until range_floor > range_ceiling
      range_values << "#{range_floor} - #{range_floor + 9}: "
      range_floor += 10
    end
    range_values
  end

  def self.find_trip_average_by_degree_range(range_floor)
    total_trips = where('? <= max_temperature AND ? >= max_temperature', range_floor, range_floor + 9)
    .joins(:trips)
    .count

    number_of_conditions = where('? <= max_temperature AND ? >= max_temperature', range_floor, range_floor + 9).count

    total_trips / number_of_conditions
  end

  def self.find_trip_max_by_degree_range(range_floor)
    where('? <= max_temperature AND ? >= max_temperature', range_floor, range_floor + 9)
      .joins(:trips)
      .select("count(trips.id) AS trip_count, conditions.id")
      .group("conditions.id")
      .order("trip_count DESC")
      .first
      .trip_count
  end

  def self.find_trip_min_by_degree_range(range_floor)
    where('? <= max_temperature AND ? >= max_temperature', range_floor, range_floor + 9)
      .joins(:trips)
      .select("count(trips.id) AS trip_count, conditions.id")
      .group("conditions.id")
      .order("trip_count")
      .first
      .trip_count
  end

  def self.collect_descriptors_for_each_ten_degree_temp_range
    range_floor = find_lowest_max_temp
    range_ceiling = find_highest_max_temp
    all_temp_descriptors = []
    until range_floor > range_ceiling
      range_descriptors = []
      range_descriptors << find_trip_average_by_degree_range(range_floor)
      range_descriptors << find_trip_max_by_degree_range(range_floor)
      range_descriptors << find_trip_min_by_degree_range(range_floor)
      all_temp_descriptors << range_descriptors
      range_floor += 10
    end
    all_temp_descriptors
  end

  def self.find_max_precipitation
    max = maximum(:precipitation)
    if max.round > max
      max.round - 0.5
    else
      max.round + 0.5
    end
  end

  def self.collect_max_precipitation_ranges
    range_floor = 0
    range_ceiling = find_max_precipitation
    range_values = []
    until range_floor > range_ceiling
      range_values << "#{range_floor} - #{range_floor + 0.49}: "
      range_floor += 0.5
    end
    range_values
  end

  def self.find_trip_max_by_precipitation_range(range_floor)
    conditions_in_range =
    where('? <= precipitation AND ? > precipitation', range_floor, range_floor + 0.5)
      .joins(:trips)
      .select("count(trips.id) AS trip_count, conditions.id")
      .group("conditions.id")
      .order("trip_count DESC")
      .first
    if conditions_in_range.nil?
      0
    else
      conditions_in_range.trip_count
    end
  end

  def self.find_trip_min_by_precipitation_range(range_floor)
    conditions_in_range =
    where('? <= precipitation AND ? >= precipitation', range_floor, range_floor + 0.5)
      .joins(:trips)
      .select("count(trips.id) AS trip_count, conditions.id")
      .group("conditions.id")
      .order("trip_count")
      .first
      if conditions_in_range.nil?
        0
      else
        conditions_in_range.trip_count
      end
  end

  def self.find_trip_average_by_precipitation_range(range_floor)
    total_trips = where('? <= precipitation AND ? >= precipitation', range_floor, range_floor + 0.5)
    .joins(:trips)
    .count
    return 0 if total_trips == 0
    number_of_conditions = where('? <= precipitation AND ? >= precipitation', range_floor, range_floor + 0.5).count

    total_trips / number_of_conditions
  end

  def self.collect_descriptors_for_each_precipitation_range
    range_floor = 0
    range_ceiling = find_max_precipitation
    all_precipitation_descriptors = []
    until range_floor > range_ceiling
      range_descriptors = []
      range_descriptors << find_trip_average_by_precipitation_range(range_floor)
      range_descriptors << find_trip_max_by_precipitation_range(range_floor)
      range_descriptors << find_trip_min_by_precipitation_range(range_floor)
      all_precipitation_descriptors << range_descriptors
      range_floor += 0.5
    end
    all_precipitation_descriptors
  end

  def self.find_max_wind_speed
    maximum(:mean_wind_speed)
  end

  def self.collect_max_wind_speed_range
    range_floor = 0
    range_ceiling = find_max_wind_speed
    range_values = []
    until range_floor > range_ceiling
      range_values << "#{range_floor} - #{range_floor + 4}: "
      range_floor += 4
    end
    range_values
  end

  def self.find_trip_max_by_mean_wind_speed_range(range_floor)
    conditions_in_range =
    where('? <= mean_wind_speed AND ? > mean_wind_speed', range_floor, range_floor + 4)
      .joins(:trips)
      .select("count(trips.id) AS trip_count, conditions.id")
      .group("conditions.id")
      .order("trip_count DESC")
      .first
    if conditions_in_range.nil?
      0
    else
      conditions_in_range.trip_count
    end
  end

  def self.find_trip_min_by_mean_wind_speed_range(range_floor)
    conditions_in_range =
    where('? <= mean_wind_speed AND ? >= mean_wind_speed', range_floor, range_floor + 4)
      .joins(:trips)
      .select("count(trips.id) AS trip_count, conditions.id")
      .group("conditions.id")
      .order("trip_count")
      .first
      if conditions_in_range.nil?
        0
      else
        conditions_in_range.trip_count
      end
  end

  def self.find_trip_average_by_mean_wind_speed_range(range_floor)
    total_trips = where('? <= mean_wind_speed AND ? >= mean_wind_speed', range_floor, range_floor + 4)
      .joins(:trips)
      .count

    return 0 if total_trips == 0

    number_of_conditions = where('? <= mean_wind_speed AND ? >= mean_wind_speed', range_floor, range_floor + 4).count

    total_trips / number_of_conditions
  end

  def self.collect_descriptors_for_each_mean_wind_speed_range
    range_floor = 0
    range_ceiling = find_max_wind_speed
    all_wind_speed_descriptors = []
    until range_floor > range_ceiling
      range_descriptors = []
      range_descriptors << find_trip_average_by_mean_wind_speed_range(range_floor)
      range_descriptors << find_trip_max_by_mean_wind_speed_range(range_floor)
      range_descriptors << find_trip_min_by_mean_wind_speed_range(range_floor)
      all_wind_speed_descriptors << range_descriptors
      range_floor += 4
    end
    all_wind_speed_descriptors
  end

  def self.find_max_visibility
    maximum(:mean_visibility)
  end

  def self.collect_max_visbility_range
    range_floor = 0
    range_ceiling = find_max_visibility
    range_values = []
    until range_floor > range_ceiling
      range_values << "#{range_floor} - #{range_floor + 4}: "
      range_floor += 4
    end
    range_values
  end

  def self.find_trip_max_by_mean_visibility_range(range_floor)
    conditions_in_range =
    where('? <= mean_visibility AND ? > mean_visibility', range_floor, range_floor + 4)
      .joins(:trips)
      .select("count(trips.id) AS trip_count, conditions.id")
      .group("conditions.id")
      .order("trip_count DESC")
      .first
    if conditions_in_range.nil?
      0
    else
      conditions_in_range.trip_count
    end
  end

  def self.find_trip_min_by_mean_visibility_range(range_floor)
    conditions_in_range =
    where('? <= mean_visibility AND ? >= mean_visibility', range_floor, range_floor + 4)
      .joins(:trips)
      .select("count(trips.id) AS trip_count, conditions.id")
      .group("conditions.id")
      .order("trip_count")
      .first
      if conditions_in_range.nil?
        0
      else
        conditions_in_range.trip_count
      end
  end

  def self.find_trip_average_by_mean_visibility_range(range_floor)
    total_trips = where('? <= mean_visibility AND ? >= mean_visibility', range_floor, range_floor + 4)
      .joins(:trips)
      .count

    return 0 if total_trips == 0

    number_of_conditions = where('? <= mean_visibility AND ? >= mean_visibility', range_floor, range_floor + 4).count

    total_trips / number_of_conditions
  end

  def self.collect_descriptors_for_each_mean_visibility_range
    range_floor = 0
    range_ceiling = find_max_visibility
    all_visibility_descriptors = []
    until range_floor > range_ceiling
      range_descriptors = []
      range_descriptors << find_trip_average_by_mean_visibility_range(range_floor)
      range_descriptors << find_trip_max_by_mean_visibility_range(range_floor)
      range_descriptors << find_trip_min_by_mean_visibility_range(range_floor)
      all_visibility_descriptors << range_descriptors
      range_floor += 4
    end
    all_visibility_descriptors
  end

  def self.find_condition_with_most_trips
    joins(:trips)
      .select("count(trips.id) AS trip_count, conditions.*")
      .group("conditions.id")
      .order("trip_count DESC")
      .first
  end

  def self.find_condition_with_least_trips
    joins(:trips)
      .select("count(trips.id) AS trip_count, conditions.*")
      .group("conditions.id")
      .order("trip_count")
      .first
  end

end
