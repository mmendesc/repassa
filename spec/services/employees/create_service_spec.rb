require 'rails_helper'

RSpec.describe Employees::CreateService do
  subject(:create_employee) { described_class.run(params) }

  let(:params) do
    {
      name: 'Matheus',
      email: 'matheus@teste.email.com',
      password: '12345678',
      password_confirmation: '12345678',
    }
  end

  it 'create a employee' do
    expect { create_employee }.to change(Employee, :count).from(0).to(1)
  end
end