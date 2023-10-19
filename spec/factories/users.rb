FactoryBot.define do
  factory :user do
    password { Faker::Internet.password }
    email { Faker::Internet.email }
    name { Gimei.name }
  end
end
