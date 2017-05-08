require "spec_helper"

describe(Project) do
  describe("#employees") do
    it("lists all the employees on a project") do
      test_project = Project.create({:name => "Morrison Bridge", :description => "repair bridge"})
      test_employee1 = Employee.create({:name => "Jimmy", :division_id => nil, :project_id => test_project.id})
      test_employee2 = Employee.create({:name => "Scarlet", :division_id => nil, :project_id => test_project.id})
      expect(test_project.employees).to eq [test_employee1, test_employee2]
    end
  end
end
