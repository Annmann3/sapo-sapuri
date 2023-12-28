FactoryBot.define do
  factory :dosage do
    amount { 500 }
    dosage_at { 6.hours.ago }
    nutrient_id { 1 }
    association :user
  end
end
