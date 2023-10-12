FactoryBot.define do
  factory :user do
    provider { 'email' }
    uid { Faker::Internet.email }
    password { Faker::Internet.password }
    email { uid }
    name { Faker::Name.name }
  end
end
