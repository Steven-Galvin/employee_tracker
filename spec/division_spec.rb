require "spec_helper"

describe(Division) do
  describe("#employees") do
    it("lists all the employees of a division") do
      test_division = Division.create({:name => "HR"})
      test_employee1 = Employee.create({:name => "Jimmy", :division_id => test_division.id})
      test_employee2 = Employee.create({:name => "Scarlet", :division_id => test_division.id})
      expect(test_division.employees).to eq [test_employee1, test_employee2]
    end
  end
end
