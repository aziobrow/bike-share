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
    # total_conditions = where('? <= max_temperature AND ? >= max_temperature', range_floor, range_floor + 9)
    #   .joins(:trips)
    #   .select("count(trips.id) AS trip_count, conditions.id")
    #   .sum(:trip_count)
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


end
