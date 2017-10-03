class BikeShareApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  get "/" do
    erb :dashboard
  end

  get "/stations" do
    @stations = Station.all
    erb :index
  end

  get "/stations/new" do
    erb :new
  end

  post "/stations" do
    Station.create(params[:station])
    redirect "/stations"
  end

  get "/stations/:id" do
    @station = Station.find(params[:id])
    erb :show
  end

  get "/stations/:id/edit" do
    @station = Station.find(params[:id])
    erb :edit
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
