# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create!(
  name: "admin",
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password"
)

vc = Nutrient.create!(
  name: "Vitamin C",
  graph_type: 2,
  dosage_recommendation: "1.5g per day",
  default_unit: "mg",
  vdf: 35.0,
  ke: 0.33,
  ka: 0.33
)

Dosage.create!(
  user_id: user.id,
  nutrient_id: vc.id,
  dosage: 1000,
  dosage_at: Time.now - 6.hours
)

Dosage.create!(
  user_id: user.id,
  nutrient_id: vc.id,
  dosage: 1000,
  dosage_at: Time.now - 3.hours
)

Dosage.create!(
  user_id: user.id,
  nutrient_id: vc.id,
  dosage: 1000,
  dosage_at: Time.now
)
