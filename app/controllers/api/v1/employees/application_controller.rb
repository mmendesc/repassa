# frozen_string_literal: true

# Base controller for employees
class Api::V1::Employees::ApplicationController < ApplicationController
  before_action :authenticate_employee!
end