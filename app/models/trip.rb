class Trip < ActiveRecord::Base
  belongs_to :condition
  belongs_to :start_station, class_name: "Station", foreign_key: "original_station_id", primary_key: "original_station_id"
  belongs_to :end_station, class_name: "Station", foreign_key: "end_station_id", primary_key: "original_station_id"

  validates :duration, presence: true
  validates :start_date, presence: true
  validates :start_station_id, presence: true
  validates :end_date, presence: true
  validates :end_station_id, presence: true
  validates :bike_id, presence: true
  validates :subscription_type, presence: true

  def starting_station_name
    start_station
    .name
  end

  def ending_station_name
    end_station
    .name
  end

  def self.average_duration_of_a_ride
    average(:duration)
    .round
  end

  def self.longest_ride
    maximum(:duration)
  end

  def self.shortest_ride
    minimum(:duration)
  end

  def self.most_frequent_station(column, asc_or_desc)
    id = find_min_or_max_id(column, asc_or_desc)
    find_by(original_station_id: id)
      .start_station
      .name
  end

  def self.time_period_with_rides(month_or_year, format_indicator)
    increments =
    group("DATE_TRUNC('#{month_or_year}', start_date)")
      .count
      .keys

    increments.map do |increment|
      increment.strftime("#{format_indicator}")
    end
  end

  def self.number_of_rides_per_time_period(month_or_year, month_or_year_value)
    where("extract(#{month_or_year} from start_date) = ?", month_or_year_value)
      .count
  end

#not sure how or if this is being used yet
  def self.display_monthly_rides(year_value)
    where('extract(year from start_date) = ?', year_value)
      time_period_with_rides("month", "%B")
  end

  def self.find_min_or_max(column, asc_or_desc)
    group("#{column}")
      .order("count_id #{asc_or_desc}")
      .count(:id)
  end

  def self.find_min_or_max_id(column, asc_or_desc)
    find_min_or_max(column, asc_or_desc)
      .keys
      .first
  end

  def self.find_min_or_max_count(column, asc_or_desc)
    find_min_or_max(column, asc_or_desc)
      .values
      .first
  end
  #
  # def self.bike_analytics
  #   find_min_or_max("bike_id", "DESC")
  # end

  def self.subscription_breakdown
    group(:subscription_type)
      .count
      .values
  end

  def self.find_user_count_for_subscription_type(customer_or_subscriber)
    if customer_or_subscriber == "customer"
      subscription_breakdown
        .first
    else
      subscription_breakdown
        .last
    end
  end

  def self.calculate_percentage(customer_or_subscriber)
    user_count = find_user_count_for_subscription_type(customer_or_subscriber)
    total = Trip.count
    (user_count.to_f / total * 100).round
  end
  #
  # def self.date_analytics
  #   find_min_or_max("end_date")
  # end

  # def self.display_date(date)
  #   date.strftime("%m/%d/%Y")
  # end

  # def self.condition_with_most_or_least_trips(asc_or_desc)
  #   condition_id = joins(:condition)
  #     .group("condition_id")
  #     .order("count_id #{asc_or_desc}")
  #     .count(:id)
      # .first

    # Condition.find(condition_id.first)

  # def self.condition_with_most_or_least_trips(asc_or_desc)
  #   condition_id = joins(:condition)
  #     find_min_or_max("condition_id", asc_or_desc)
  #
  #   find_by(condition_id: condition_id)
  #     .condition
  # end

end
