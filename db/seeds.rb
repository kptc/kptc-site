# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Player.create!(
  first_name: 'Ben',
  last_name: 'Weddel',
  role: 'A',
  gender: 'M',
  email: 'change.your@email.com',
  phone: '416-555-1234',
  password: 'password',
  password_confirmation: 'password'
)
Player.create!(
  first_name: 'Barbara',
  last_name: 'Goss',
  role: 'A',
  gender: 'F',
  email: 'rzezbiarz@aggosst.com',
  phone: '416-651-5205',
  password: 'password',
  password_confirmation: 'password'
)

SessionType.create(name: 'Competitive')
SessionType.create(name: 'Recreational')