FactoryBot.define do
  factory :manager do
    sequence(:name) { |i| "Manager #{i}" }
    sequence(:email) { |i| "manager#{i}@teste.com" }
    password { '12345678' }
    password_confirmation { '12345678' }
    token { 'asdlka' }
  end
end