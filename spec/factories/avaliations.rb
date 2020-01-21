FactoryBot.define do
  factory :avaliation do
    sequence(:grade) { |i| i }
    sequence(:comment) { |i| "lorem ipsum #{i}" }

    manager
    employee
  end
end