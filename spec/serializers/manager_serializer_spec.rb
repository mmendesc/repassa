# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ManagerSerializer, type: :serializer do
  subject(:serialized_manager) { described_class.new(manager).serializable_hash }

  let(:manager) { create(:manager) }

  it 'return serialized attributes' do
    expect(serialized_manager).to include_json(
      data: {
        id: manager.id.to_s,
        attributes: {
          name: manager.name,
          email: manager.email
        }
      }
    )
  end
end
