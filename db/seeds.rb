# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user = User.create(name: 'eva', email: 'evayuhz@gmail.com', password: 'foobar', password_confirmation: 'foobar')
other = User.create(name: 'other', email: "other@gmail.com", password: 'foobar', password_confirmation: 'foobar')


user.teams.create([{ name: 'team1' }, { name: 'team2' }, { name: 'team3' } ])
team = Team.first
other_team = other.teams.create(name: 'other team')

team.projects.create([{name: 'project1', description: 'desc for project1'}, {name: 'project2', description: 'desc for project2'}, {name: 'project3', description: 'desc for project3'}])
project = Project.first
project.todos.create(content: 'todo1: get a job', assigned_to: user.id, author_id: user.id, end_time: '2014-10-1')

other_team.projects.create(name: "other team project", description: "desc for other team project")

Todo.statuses.each do |status, value|
  project.todos.create!(content: "#{status}", status: value, author_id: user.id)
end
