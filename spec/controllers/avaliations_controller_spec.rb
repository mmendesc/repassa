# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AvaliationsController, type: :controller do
  let(:manager) { create(:manager) }
  let(:employee) { create(:employee) }
  let(:avaliation) { create(:avaliation, manager: manager, employee: employee) }

  before do
    sign_in manager
  end

  describe 'POST #create' do
    subject(:create_avaliation) { post :create, params: params }

    let(:params) do
      {
        avaliation: {
          grade: 10,
          comment: 'lorem ipsum',
          employee_id: employee.id
        }
      }
    end

    it 'create a avaliation' do
      expect { create_avaliation }.to change(Avaliation, :count).from(0).to(1)
    end
  end

  describe 'GET #show' do
    subject(:show_avaliation) { get :show, params: { id: avaliation.id }}

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
  end

  describe 'GET #index' do
    subject(:avaliation_index) { get :index }

    let!(:avaliations) { create_list(:avaliation, 2) }

    it 'return all avaliations' do
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
  end

  describe 'PATCH #update' do
    subject(:update_avaliation) { patch :update, params: { id: avaliation.id, avaliation: { comment: 'Novo comentario' }}}

    it 'updates avaliation info' do
      update_avaliation
      expect(avaliation.reload.comment).to eq 'Novo comentario'
    end
  end

  describe 'DELETE #destroy' do
    subject(:destroy_avaliation) { delete :destroy, params: { id: avaliation.id }}

    let!(:avaliation) { create(:avaliation) }

    it 'destroy a avaliation' do
      expect { destroy_avaliation }.to change(Avaliation, :count).from(1).to(0)
    end
  end
end