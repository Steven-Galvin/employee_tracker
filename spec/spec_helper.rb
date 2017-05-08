ENV['RACK_ENV'] = 'test'
require "rspec"
require "pg"
require "sinatra/activerecord"
require "division"
require "employee"
require "pry"


RSpec.configure do |config|
  config.after(:each) do
    Employee.all.each do |employee|
      employee.destroy
    end
  end
end
