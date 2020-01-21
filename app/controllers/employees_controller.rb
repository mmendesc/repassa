class EmployeesController < ApplicationController
  def index
    @employees = Employee.all

    render json: EmployeeSerializer.new(@employees)
  end

  def create
    @employee = Employees::CreateService.run(employee_params).result

    render json: EmployeeSerializer.new(@employee)
  end

  private

  def employee_params
    params.require(:employee).permit(
      :name, :email, :password, :password_confirmation
    )
  end
end