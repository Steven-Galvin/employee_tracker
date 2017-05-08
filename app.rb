require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './lib/division'
require './lib/employee'
require './lib/project'
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

#ADD DIVISION EMPLOYEE
post '/division/:id/add_employee' do
  division_id = params['id']
  name = params['name']
  Employee.new(:name => name, :division_id => division_id).save
  redirect("/division/#{division_id}")
end

#DIVISION EMPLOYEE UPDATE/DELETE
get '/division/:division_id/employee/:employee_id' do
  @division = Division.find(params['division_id'])
  @employee = Employee.find(params['employee_id'])
  erb(:division_employee)
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


#PROJECTS PAGE
get '/projects' do
  @projects = Project.all
  erb(:projects)
end

post '/add_project' do
  name = params['name']
  description = params['description']
  Project.new(:name => name, :description => description).save
  redirect("/projects")
end

#PROJECT PAGE
get '/project/:id' do
  @project = Project.find(params['id'])
  @employees = Employee.all
  erb(:project)
end

patch '/project/:id/employee_select' do
  project_id = params['id']
  employee = Employee.find(params['employee_id'].to_i)
  employee.update(:project_id => project_id)
  redirect("/project/#{project_id}")
end

get '/project/:project_id/employee/:employee_id' do
  @project = Project.find(params['project_id'])
  @employee = Employee.find(params['employee_id'])
  erb(:project_employee)
end

#PROJECT EMPLOYEE UPDATE/DELETE

patch '/project/:project_id/employee/:employee_id' do
  project_id = params['project_id']
  employee_id = params['employee_id']
  name = params['name']
  current_employee = Employee.find(employee_id)
  current_employee.update(:name => name)
  redirect ("/project/#{project_id}/employee/#{employee_id}")
end

delete '/project/:project_id/employee/:employee_id/delete' do
  project_id = params['project_id']
  employee = Employee.find(params['employee_id'])
  employee.destroy
  redirect("/project/#{project_id}")
end


# PROJECT UPDATE/DELETE

delete '/project/:id/delete' do
  current_project = Project.find(params['id'])
  current_project.destroy
  redirect '/projects'
end


patch '/project/:id/update' do
  current_project = Project.find(params['id'])
  name = params['name']
  current_project.update(:name => name)
  redirect("/project/#{current_project.id}")
end


# EMPLOYEE LISTS
get '/employees' do
  @employees = Employee.all
  erb(:employees)
end
