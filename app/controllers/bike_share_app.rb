require 'pry'

class BikeShareApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  get "/" do
    erb :dashboard
  end

  get "/stations" do
    @stations = Station.all
    erb :'/stations/index'
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

  get "/stations/:id/edit" do
    @station = Station.find(params[:id])
    erb :"stations/edit"
  end

  put "/stations/:id" do |id|
    Station.update(id.to_i, params[:station])
    redirect "/stations/#{id}"
  end

  delete "/stations/:id" do |id|
    Station.destroy(id.to_i)
    redirect "/stations"
  end
end
