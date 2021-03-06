# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Employees::SessionsController, type: :controller do
  let(:employee) { create(:employee) }

  describe 'POST #create' do
    subject(:login) { post :create, params: params }

    let(:params) do
      {
        login: {
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

  describe 'DELETE #destroy' do
    subject(:sign_out) { delete :destroy }

    before do
      request.headers.merge!({ 'Authorization' => "Bearer #{employee.token}"})
    end

    it 'sign out' do
      sign_out
      expect(response).to have_http_status(200)
    end
  end
end
