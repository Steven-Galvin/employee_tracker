require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './lib/division'
require './lib/employee'
require 'pry'

also_reload('lib/**/*.rb')

get '/' do
  @divisions = Division.all
  erb(:index)
end

# ADD DIVISION
get '/add_division'do
  erb(:add_division)
end

post '/add_division' do
  name = params['name']
  Division.new(:name => name).save
  redirect('/')
end


#DIVISION PAGE
get '/division/:id' do
  @division = Division.find(params['id'])
  @div_employees = @division.employees
  erb(:division)
end

delete '/division/:id/delete' do
  current_division = Division.find(params['id'])
  current_division.destroy
  redirect '/'
end

#DIVISION UPDATE
get '/division/:id/update' do
  @division = Division.find(params['id'])
  erb(:division_update)
end

patch '/division/:id/update' do
  current_division = Division.find(params['id'])
  name = params['name']
  current_division.update(:name => name)
  redirect("/division/#{current_division.id}")
end

#ADD EMPLOYEE
post '/division/:id/add_employee' do
  division_id = params['id']
  name = params['name']
  Employee.new(:name => name, :division_id => division_id).save
  redirect("/division/#{division_id}")
end

#EMPLOYEE PAGE/UPDATE
get '/division/:division_id/employee/:employee_id' do
  @division = Division.find(params['division_id'])
  @employee = Employee.find(params['employee_id'])
  erb(:employee)
end

patch '/division/:division_id/employee/:employee_id' do
  division_id = params['division_id']
  employee_id = params['employee_id']
  name = params['name']
  current_employee = Employee.find(employee_id)
  current_employee.update(:name => name)
  redirect ("/division/#{division_id}/employee/#{employee_id}")
end

delete '/division/:division_id/employee/:employee_id/delete' do
  division_id = params['division_id']
  employee = Employee.find(params['employee_id'])
  employee.destroy
  redirect("/division/#{division_id}")
end
