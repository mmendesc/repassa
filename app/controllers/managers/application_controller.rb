# frozen_string_literal: true

# Base controller for managers
class Managers::ApplicationController < ApplicationController
  before_action :authenticate_manager!
end