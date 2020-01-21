# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Managers::EmployeesController, type: :controller do
  let(:employee) { create(:employee) }

  describe 'POST #create' do
    subject(:create_employee) { post :create, params: params}

    let(:params) { {} }
    let(:employee) { create(:employee) }

    context 'with valid params' do
      let(:params) do
        {
          employee: {
            name: 'Matheus',
            email: 'matheus@teste.email.com',
            password: '12345678',
            password_confirmation: '12345678',
          }
        }
      end

      it 'create a employee' do
        expect { create_employee }.to change(Employee, :count).from(0).to(1)
      end

      it 'calls create service' do
        double = double(result: employee)
        allow(Employees::CreateService).to receive(:run).with(valid_params).and_return(double)
        create_employee

        expect(Employees::CreateService).to have_received(:run).with(valid_params).once
      end

      it 'return serialized employee' do
        double = double(result: employee)
        allow(Employees::CreateService).to receive(:run).with(valid_params).and_return(double)
        create_employee

        expect(JSON.parse(response.body)).to include_json(
          data: {
            id: employee.id.to_s,
            attributes: {
              name: employee.name,
              email: employee.email
            }
          }
        )
      end

      def valid_params
        ActionController::Parameters.new(params[:employee]).permit!
      end
    end
  end

  describe 'GET #show' do
    subject(:show_employee) { get :show, params: { id: employee.id }}

    it 'return serialized employee' do
      show_employee
      expect(JSON.parse(response.body)).to include_json(
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

  describe 'GET #index' do
    subject(:employee_index) { get :index }

    let!(:employees) { create_list(:employee, 2) }

    it 'return all employees' do
      employee_index
      expect(JSON.parse(response.body)).to include_json(
        data: [
          {
            id: employees[0].id.to_s,
            attributes: {
              name: employees[0].name,
              email: employees[0].email
            }
          },
          {
            id: employees[1].id.to_s,
            attributes: {
              name: employees[1].name,
              email: employees[1].email
            }
          }
        ]
      )
    end
  end

  describe 'PATCH #update' do
    subject(:update_employee) { patch :update, params: { id: employee.id, employee: { name: 'Novo nome' }}}

    it 'updates employee info' do
      update_employee
      expect(employee.reload.name).to eq 'Novo nome'
    end
  end

  describe 'DELETE #destroy' do
    subject(:destroy_employee) { delete :destroy, params: { id: employee.id }}

    let!(:employee) { create(:employee) }

    it 'destroy a employee' do
      expect { destroy_employee }.to change(Employee, :count).from(1).to(0)
    end
  end
end
