# frozen_string_literal: true

# Base controller for employees
class Employees::ApplicationController < ApplicationController
  before_action :authenticate_employee!
end