FactoryBot.define do
  factory :nutrient do
    name { 'ビタミンC' }
    dosage_recommendation { '1.5g per day' }
    graph_type { 2 }
    vdf { 35.0 }
    ke { 0.33 }
    ka { 0.33 }
    default_unit { 'mg' }
  end
end
