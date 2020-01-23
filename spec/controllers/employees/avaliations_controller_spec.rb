# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Employees::AvaliationsController, type: :controller do
  let(:employee) { create(:employee) }
  let(:avaliation) { create(:avaliation, employee: employee) }
  let(:another_avaliation) { create(:avaliation) }

  before do
    request.headers.merge!({ 'Authorization' => "Bearer #{employee.token}"})
  end
  describe 'GET #show' do
    subject(:show_avaliation) { get :show, params: params }

    let(:params) do
      { id: avaliation.id }
    end

    it 'return serialized avaliation' do
      show_avaliation
      expect(JSON.parse(response.body)).to include_json(
        data: {
          id: avaliation.id.to_s,
          attributes: {
            grade: avaliation.grade,
            comment: avaliation.comment
          }
        }
      )
    end

    it 'return 200 ok' do
      show_avaliation
      expect(response).to have_http_status(200)
    end

    context 'when try to access avaliation from other employee' do
      let(:params) do
        { id: another_avaliation.id }
      end

      it 'return error' do
        show_avaliation
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET #index' do
    subject(:avaliation_index) { get :index }

    let!(:avaliations) { create_list(:avaliation, 2, employee: employee) }
    let!(:another_avaliation) { create(:avaliation, comment: 'dalksjd') }

    it 'return all avaliations from current employee' do
      avaliation_index
      expect(JSON.parse(response.body)).to include_json(
        data: [
          {
            id: avaliations[0].id.to_s,
            attributes: {
              grade: avaliations[0].grade,
              comment: avaliations[0].comment
            }
          },
          {
            id: avaliations[1].id.to_s,
            attributes: {
              grade: avaliations[1].grade,
              comment: avaliations[1].comment
            }
          }
        ]
      )
    end

    it "doesn't return avaliations from other employees" do
      avaliation_index
      expect(JSON.parse(response.body)).not_to include_json(
        data: [
          {
            id: another_avaliation.id.to_s,
            attributes: {
              grade: another_avaliation.grade,
              comment: another_avaliation.comment
            }
          }
        ]
      )
    end
  end
end