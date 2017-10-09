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

  def self.find_trip_count_by_degree_range(range_floor)
    condition_ids = where('? <= max_temperature AND ? >= max_temperature', range_floor, range_floor + 9)
      .select(:id)

    Trip.where('condition_id IN (?)', condition_ids).count

    # Trip.where(condition_id:  )


    # range_conditions.reduce(0) do |sum, condition|
    #   sum + condition.trips.count
    # end
    #
    # until range_floor > find_highest_max_temp
    #   find_trip_count_by_degree_range(range_floor + 10)
    # end
  end

  # select('conditions.*', )

end
