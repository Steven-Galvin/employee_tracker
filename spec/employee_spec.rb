require "spec_helper"

describe(Employee) do
  describe("#division") do
    it("lists the division of a employee") do
      test_division = Division.create({:name => "HR"})
      puts test_division.id
      test_employee = Employee.create({:name => "Jimmy", :division_id => test_division.id})
      expect(test_employee.division).to eq test_division
    end
  end
end
