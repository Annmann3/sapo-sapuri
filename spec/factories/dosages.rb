FactoryBot.define do
  factory :dosage do
    amount { 500 }
    dosage_at { Time.now - 6.hours }
    association :user
    association :nutrient
  end
end
