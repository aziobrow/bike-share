class BikeShareApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)

  get "/" do
    erb :dashboard
  end

  get "/stations" do
    erb :index
  end

  get "/stations/new" do
    erb :new
  end

  post "/stations" do
    redirect "/stations"
  end

  get "/stations/:id" do
    erb :show
  end

  get "/stations/:id/edit" do
    erb :edit
  end

  set :method_override, true
  put "/stations/:id" do |id|

    redirect "/stations/#{id}"
  end

  delete "/stations/:id" do |id|

    redirect "/stations"
  end
end
