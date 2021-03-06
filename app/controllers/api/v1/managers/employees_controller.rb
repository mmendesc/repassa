# frozen_string_literal: true

# Controller of employees
class Api::V1::Managers::EmployeesController < Api::V1::Managers::ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_employee, except: %i[index create]

  def index
    @employees = Employee.all

    render json: EmployeeSerializer.new(@employees)
  end

  def show
    render json: EmployeeSerializer.new(@employee)
  end

  def create
    @employee = ::Employees::CreateService.run(employee_params).result

    render json: EmployeeSerializer.new(@employee)
  end

  def update
    if @employee.update(employee_params)
      render json: EmployeeSerializer.new(@employee)
    else
      render json: @employee.errors, status: 422
    end
  end

  def destroy
    if @employee.destroy
      render json: {}, status: 200
    else
      render json: @employee.errors, status: 422
    end
  end

  def avaliations
    @avaliations = @employee.avaliations

    render json: AvaliationSerializer.new(@avaliations)
  end

  private

  def set_employee
    @employee = Employee.find_by(id: params[:id])

    return if @employee

    render json: { error: 'Não encontrado' }, status: 404
  end

  def employee_params
    params.require(:employee).permit(
      :id, :name, :email, :password, :password_confirmation
    )
  end
end