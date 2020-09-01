FactoryBot.define do
  factory :invoice do
    association :customer
    status { "MyText" }
  end
end
