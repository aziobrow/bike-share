ENV["RACK_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require 'rspec'
require 'capybara/dsl'

Bundler.require(:default, :test)
Capybara.app = BikeShareApp
DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.include Capybara::DSL

  config.before(:all) do
    DatabaseCleaner.clean
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
