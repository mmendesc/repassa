class Employees::CreateService < ApplicationService
  attr_reader :params, :employee

  def initialize(params)
    @params = params
    @employee = nil
  end

  def run
    create_employee
    @employee
  end

  private

  def create_employee
    @employee = Employee.new(params)
    @employee.token = Devise.friendly_token
    @employee.save
  end
end