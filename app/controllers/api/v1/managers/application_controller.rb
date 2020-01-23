# frozen_string_literal: true

# Base controller for managers
class Api::V1::Managers::ApplicationController < ApplicationController
  before_action :authenticate_token

  def current_manager
    @current_manager
  end

  private

  def authenticate_token
    @current_manager = Manager.find_by(token: request_token)
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
    nil
  end
end