# frozen_string_literal: true

# Controller of avaliations
class Managers::AvaliationsController < Managers::ApplicationController
  before_action :set_avaliation, except: %i[index create]

  def index
    @avaliations = Avaliation.all

    render json: AvaliationSerializer.new(@avaliations)
  end

  def show
    render json: AvaliationSerializer.new(@avaliation)
  end

  def create
    @avaliation = Avaliation.new(avaliation_params) do |avaliation|
      avaliation.manager_id = current_manager.id
    end

    if @avaliation.save
      render json: AvaliationSerializer.new(@avaliation)
    else
      render json: @avaliation.errors, status: 422
    end
  end

  def update
    if @avaliation.update(avaliation_params)
      render json: AvaliationSerializer.new(@avaliation)
    else
      render json: @avaliation.errors, status: 422
    end
  end

  def destroy
    if @avaliation.destroy
      render json: {}, status: 200
    else
      render json: @avaliation.errors, status: 422
    end
  end

  private

  def set_avaliation
    @avaliation = Avaliation.find(params[:id])
  end

  def avaliation_params
    params.require(:avaliation).permit(:grade, :comment, :employee_id)
  end
end
