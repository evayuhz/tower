# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user = User.create(name: 'eva', email: 'evayuhz@gmail.com', password: 'foobar', password_confirmation: 'foobar')
user.teams.create([{ name: 'team1' }, { name: 'team2' }, { name: 'team3' } ])

