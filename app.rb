require 'sinatra'
require 'sinatra/reloader'
require 'sinatra-activerecord'
require './lib/Employee_Tracker'
require 'pry'

also_reload('lib/**/*.rb')

get('/') do
  erb(:index)
end
