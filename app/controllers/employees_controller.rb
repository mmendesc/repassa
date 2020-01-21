class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[update]

  def index
    @employees = Employee.all

    render json: EmployeeSerializer.new(@employees)
  end

  def create
    @employee = Employees::CreateService.run(employee_params).result

    render json: EmployeeSerializer.new(@employee)
  end

  def update
    if @employee.update(employee_params)
      render json: EmployeeSerializer.new(@employee)
    else
      render json: @employee.errors, status: 422
    end
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(
      :id, :name, :email, :password, :password_confirmation
    )
  end
end