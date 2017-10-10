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

  def calculate_duration
    if self.duration
      self.duration / 60
    else
      duration = self.end_date - self.start_date
      duration / 60
    end
  end

  def average_duration_of_a_ride
    Trip.average(:duration).round
  end

  def longest_ride
    Trip.maximum(:duration)
  end

  def shortest_ride
    Trip.minimum(:duration)
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

  def most_ridden_bike_with_total_number_of_rides
    Trip.group(:bike_id).order("count_id DESC").limit(1).count(:id)
  end

  def least_ridden_bike_with_total_number_of_rides
    Trip.group(:bike_id).order("count_id ASC").limit(1).count(:id)
  end

  def subscription_breakdown
    Trip.group(:subscription_type).count
  end

  def customer_percentage
    total = Trip.count
    customer = Trip.group(:subscription_type).count.values.first
    (customer.to_f / total * 100).round
  end

  def subscriber_percentage
    total = Trip.count
    subscriber = Trip.group(:subscription_type).count.values.last
    (subscriber.to_f / total * 100).round
  end

  def date_with_most_trips
    Trip.group(:end_date).order("count_id DESC").limit(1).count(:id)
  end

  def date_with_least_trips
    Trip.group(:end_date).order("count_id ASC").limit(1).count(:id)
  end

  def display_date(date)
    date.strftime("%m/%d/%Y")
  end


end
