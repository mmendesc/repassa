FactoryBot.define do
  factory :employee do
    sequence(:name) { |i| "Nome #{i}" }
    sequence(:email) { |i| "email#{i}@teste.com" }
    password { '12345678' }
    password_confirmation { '12345678' }
    token { 'asl133810' }
  end
end