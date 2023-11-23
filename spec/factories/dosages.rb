FactoryBot.define do
  factory :dosage do
    amount { 500 }
    dosage_at { 6.hours.ago }
    association :user
    association :nutrient
  end
end
