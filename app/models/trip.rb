class Trip < ActiveRecord::Base
  belongs_to :condition
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


  #I don't think we're using this?
  def calculate_duration
    if self.duration
      self.duration / 60
    else
      self.end_date - self.start_date / 60
    end
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

  def most_frequent_starting_station
    start_station_max = Trip.group(:start_station_id).order("count_id DESC").limit(1).count(:id)
    Station.find(start_station_max.keys.first).name
  end

  def most_frequent_ending_station
    start_station_min = Trip.group(:start_station_id).order("count_id ASC").limit(1).count(:id)
    Station.find(start_station_min.keys.first).name
  end

  def years_with_rides
    year_dates = Trip.group("DATE_TRUNC('year', start_date)").count.keys
    years = year_dates.map do |date|
      date.strftime("%Y")
    end
  end

  def number_of_rides_per_year
    years = years_with_rides
    yearly_rides = Hash.new
    yearly_subtotals = years.map do |year|
      yearly_rides[year] = Trip.where('extract(year from start_date) = ?', year).count
    end
    yearly_rides
  end

  def display_monthly_rides
    years = years_with_rides
    rides_per_month = Hash.new
    monthly_rides = years.each do |year|
      ride_count = Trip.where('extract(year from start_date) = ?', year).group("DATE_TRUNC('month', start_date)").count
      rides_per_month[self.start_date.strftime("%B")] = ride_count.values.first
    end
    rides_per_month
  end

  def self.find_min_or_max(column)
    group("#{column}")
    .order("count_id")
    .count(:id)
  end

  def self.bike_analytics
    find_min_or_max("bike_id")
  end

  def self.subscription_breakdown
    group(:subscription_type)
    .count
  end

  def self.find_user_count_for_subscription_type(customer_or_subscriber)
    if customer_or_subscriber == "customer"
      subscription_breakdown.values.first
    else
      subscription_breakdown.values.last
    end
  end

  def self.calculate_percentage(customer_or_subscriber)
    user_count = find_user_count_for_subscription_type(customer_or_subscriber)
    total = Trip.count
    (user_count.to_f / total * 100).round
  end
  #
  def self.date_analytics
    find_min_or_max("end_date")
  end

  def self.display_date(date)
    date.strftime("%m/%d/%Y")
  end

  def self.condition_with_most_or_least_trips(asc_or_desc)
    condition_id = joins(:condition)
      .group("condition_id")
      .order("count_id #{asc_or_desc}")
      .count(:id)
      .first

    Condition.find(condition_id.first)
  end
  # def self.find_condition_on_date_with_most_trips
  #   condition_id = joins(:condition)
  #     .group("condition_id")
  #     .order("count_id DESC")
  #     .count(:id)
  #     .first
  #
  #   Condition.find(condition_id.first)
  # end
  #
  # def self.find_condition_on_date_with_least_trips
  #   condition_id = joins(:condition)
  #     .group("condition_id")
  #     .order("count_id")
  #     .count(:id)
  #     .first
  #
  #   Condition.find(condition_id.first)
  # end

end
