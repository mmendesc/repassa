class AvaliationSerializer < ApplicationSerializer
  attributes :grade, :comment

  attribute :employee do |avaliation|
    EmployeeSerializer.new(avaliation.employee).serializable_hash
  end

  attribute :manager do |avaliation|
    ManagerSerializer.new(avaliation.manager).serializable_hash
  end
end
