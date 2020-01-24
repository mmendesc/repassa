# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Managers::SessionsController, type: :controller do
  let(:manager) { create(:manager) }

  describe 'POST #create' do
    subject(:sign_in) { post :create, params: params }

    let(:params) do
      {
        login: {
          email: manager.email,
          password: '12345678'
        }
      }
    end

    it 'sign in' do
      sign_in
      expect(response.body).to include_json(
        success: true,
        auth_token: manager.token,
        email: manager.email
      )
    end
  end

  describe 'DELETE #destroy' do
    subject(:sign_out) { delete :destroy }

    before do
      request.headers.merge!({ 'Authorization' => "Bearer #{manager.token}"})
    end

    it 'sign out' do
      sign_out
      expect(response).to have_http_status(200)
    end
  end
end
