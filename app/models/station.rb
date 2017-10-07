class Station < ActiveRecord::Base
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

end
