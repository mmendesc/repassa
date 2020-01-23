# frozen_string_literal: true

# Base controller for employees
class Api::V1::Employees::ApplicationController < ApplicationController
  before_action :authenticate_token

  respond_to :json

  def current_employee
    @current_employee
  end

  private

  def authenticate_token
    @current_employee = Employee.find_by(token: request_token)
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
    nil
  end
end

