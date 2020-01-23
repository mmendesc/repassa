# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Employees::SessionsController, type: :controller do
  let(:employee) { create(:employee) }

  describe 'POST #create' do
    subject(:login) { post :create, params: params }

    let(:params) do
      {
        employee: {
          email: employee.email,
          password: '12345678'
        }
      }
    end

    it 'sign in' do
      login
      expect(response.body).to include_json(
        success: true,
        auth_token: employee.token,
        email: employee.email
      )
    end
  end
end
