class AvaliationSerializer < ApplicationSerializer
  attributes :grade, :comment

  attribute :employee do |avaliation|
    avaliation.employee.name
  end

  attribute :manager do |avaliation|
    avaliation.manager.name
  end
end
