# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



User.create!(name: 'Rene Weteling', email: 'rene@weteling.com', password: 'password', password_confirmation: 'password', 
  clients:[
    Client.new(name: 'Sony', projects:[
      Project.new(name: 'Sony portal'),
      Project.new(name: 'Sony cloud'),
      Project.new(name: 'Sony Remote'),
    ]),
    Client.new(name: 'Lg', projects:[
      Project.new(name: 'Monitor'),
      Project.new(name: 'Tv software'),
    ]),
    Client.new(name: 'Apple', projects:[
      Project.new(name: 'iCloud'),
      Project.new(name: 'Iphone app'),
      Project.new(name: 'Kook app'),
    ]),
  ], 
  rates: [
    Rate.new(name: 'Normaal', rate: 75),
    Rate.new(name: 'Dagstaffel', rate: 62.5),
  ]
)