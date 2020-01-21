# frozen_string_literal: true

# Controller of avaliations
class Employees::AvaliationsController < Employees::ApplicationController
  before_action :set_avaliation, only: %i[show]

  def index
    @avaliations = current_employee.avaliations

    render json: AvaliationSerializer.new(@avaliations)
  end

  def show
    render json: AvaliationSerializer.new(@avaliation)
  end

  private

  def set_avaliation
    @avaliation = current_employee.avaliations.find_by(id: params[:id])

    return if @avaliation

    render json: {}, status: 422
  end
end
