# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AvaliationSerializer, type: :serializer do
  subject(:serialized_avaliation) { described_class.new(avaliation).serializable_hash }

  let(:manager) { create(:manager) }
  let(:employee) { create(:employee) }
  let(:avaliation) { create(:avaliation, manager: manager, employee: employee) }

  it 'return serialized attributes' do
    expect(serialized_avaliation).to include_json(
      data: {
        id: avaliation.id.to_s,
        attributes: {
          grade: avaliation.grade,
          comment: avaliation.comment,
          manager: {
            data: {
              id: manager.id.to_s,
              attributes: {
                name: manager.name,
                email: manager.email
              }
            }
          },
          employee: {
            data: {
              id: employee.id.to_s,
              attributes: {
                name: employee.name,
                email: employee.email
              }
            }
          }
        }
      }
    )
  end
end
