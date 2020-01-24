# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmployeeSerializer, type: :serializer do
  subject(:serialized_employee) { described_class.new(employee).serializable_hash }

  let(:employee) { create(:employee) }

  it 'return serialized attributes' do
    expect(serialized_employee).to include_json(
      data: {
        id: employee.id.to_s,
        attributes: {
          name: employee.name,
          email: employee.email
        }
      }
    )
  end
end
