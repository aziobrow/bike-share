class Station < ActiveRecord::Base
  validates :name, presence: true
  validates :city, presence: true
  validates :dock_count, presence: true
  validates :installation_date, presence: true

  def mean_number_of_bikes
    Station.average(:dock_count)
  end
end
