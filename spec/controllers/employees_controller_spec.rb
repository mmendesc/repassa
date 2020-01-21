require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
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
end