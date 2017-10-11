require 'will_paginate'
require 'will_paginate/active_record'

class BikeShareApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true
  register WillPaginate::Sinatra

  get "/" do
    erb :dashboard
  end

  get "/stations" do
    @stations = Station.all
    erb :'/stations/index'
  end

  get "/stations/:id/edit" do
    @station = Station.find(params[:id])
    erb :"/stations/edit"
  end

  get "/stations-dashboard" do
    @stations = Station.all
    erb :'/stations/dashboard'
  end

  get "/stations/new" do
    erb :"/stations/new"
  end

  post "/stations" do
    Station.create(params[:station])
    redirect "/stations"
  end

  get "/stations/:id" do
    @station = Station.find(params[:id])
    erb :"/stations/show"
  end


  put "/stations/:id" do |id|
    Station.update(id.to_i, params[:station])
    redirect "/stations/#{id}"
  end

  delete "/stations/:id" do |id|
    Station.destroy(id.to_i)
    redirect "/stations"
  end

  get "/trips" do
    @trips = Trip.all.paginate(:page => params[:page], :per_page => 30)
    erb :'/trips/index'
  end

  get "/trips/:id/edit" do
    @trip = Trip.find(params[:id])
    erb :"/trips/edit"
  end

  get "/trips-dashboard" do
    @trips = Trip.all
    @condition_with_most_rides = Condition.find_condition_with_most_trips
    @condition_with_least_rides = Condition.find_condition_with_least_trips
    @bike_analytics = Trip.bike_analytics
    @date_analytics = Trip.date_analytics
    erb :'/trips/dashboard'
  end

  get "/trips/new" do
    erb :"/trips/new"
  end

  get "/trips/:id" do
    @trip = Trip.find(params[:id])
    erb :'/trips/show'
  end

  post "/trips" do
    Trip.create(params[:trip])
    redirect "/trips"
  end


  put "/trips/:id" do |id|
    Trip.update(id.to_i, params[:trip])
    redirect "/trips/#{id}"
  end

  delete "/trips/:id" do |id|
    Trip.destroy(id.to_i)
    redirect "/trips"
  end

  get "/conditions" do
    @conditions = Condition.all.paginate(:page => params[:page], :per_page => 10)
    erb :"/conditions/index"
  end

  get "/conditions/:id/edit" do
    @condition = Condition.find(params[:id])
    erb :"/conditions/edit"
  end

  get "/conditions-dashboard" do
    @conditions = Condition.all
    @condition_temp_data = Condition.collect_descriptors_for_each_ten_degree_temp_range
    @condition_precip_data = Condition.collect_descriptors_for_each_precipitation_range
    @condition_wind_speed_data = Condition.collect_descriptors_for_each_mean_wind_speed_range
    @condition_visibility_data = Condition.collect_descriptors_for_each_mean_visibility_range
    erb :"/conditions/dashboard"
  end

  get "/conditions/new" do
    erb :"/conditions/new"
  end

  get "/conditions/:id" do
    @condition = Condition.find(params[:id])
    erb :"/conditions/show"
  end

  post "/conditions" do
    Condition.create(params[:condition])
    redirect "/conditions"
  end

  put "/conditions/:id" do |id|
    Condition.update(id.to_i, params[:condition])
    redirect "/conditions/#{id}"
  end

  delete "/conditions/:id" do |id|
    Condition.destroy(id.to_i)
    redirect "/conditions"
  end
end
