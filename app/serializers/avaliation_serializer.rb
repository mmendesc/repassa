class AvaliationSerializer < ApplicationSerializer
  attributes :grade, :comment

  attribute :employee do |avaliation|
    avaliation.employee
  end

  attribute :manager do |avaliation|
    avaliation.manager
  end
end
