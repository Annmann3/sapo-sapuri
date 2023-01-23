# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
  name: 'guest',
  email: 'guest@example.com',
  password: 'password',
  password_confirmation: 'password'
)

Nutrient.create(
  name: 'Vitamin C',
  graph_type: 2,
  dosage_recommendation: '1.5g per day',
  default_unit: 'mg',
  vdf: 35.0,
  ke: 0.33,
  ka: 0.33
)
