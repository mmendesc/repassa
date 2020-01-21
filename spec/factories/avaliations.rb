FactoryBot.define do
  factory :avaliation do
    sequence(:grade) { |i| i }
    comment { 'lorem ipsum' }

    manager
    employee
  end
end