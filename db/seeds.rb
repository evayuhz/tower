# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# user: self and other
password = { password: 'foobar', password_confirmation: 'foobar' }
user = User.create({name: 'eva', email: 'evayuhz@gmail.com'}.merge(password) )
other = User.create({name: "other", email: "other@gmail.com"}.merge(password) )

# team: self created team and join other team as serveral role
team = user.teams.create({ name: 'own team1 as leader' })
other_team = other.teams.create(name: 'other team that not joined')
other_as_admin_team = other.teams.create(name: 'other as admin team')
other_as_member_team = other.teams.create(name: 'other as member team')
other_as_visitor_team = other.teams.create(name: 'other as visitor team')

other_as_admin_team.team_members.create(user_id: user.id, role: 0)
other_as_member_team.team_members.create(user_id: user.id, role: 1)
other_as_visitor_team.team_members.create(user_id: user.id, role: 2)

# projects and todos: self team's projects and todos 
team.projects.create([{name: 'project1', description: 'desc for project1, joined'}, 
                      {name: 'project2', description: 'desc for project2, not joined'}])
joined_project = Project.first
not_joined_project = Project.second
joined_project.project_members.create(user_id: user.id)
joined_project.todos.create(content: 'todo1: get a job', assigned_to: user.id, author_id: user.id, end_time: '2014-10-1')
Todo.statuses.each do |status, value|
  joined_project.todos.create!(content: "#{status}", status: value, author_id: user.id)
end

# other team's project 
other_admin_project = other_as_admin_team.projects.create(name: "team joined as admin, not project member")
other_member_project = other_as_member_team.projects.create(name: "team joined as member, not project member")
other_visitor_project = other_as_visitor_team.projects.create(name: "team joined as visitor, not project member")
join_other_admin_project = other_as_admin_team.projects.create(name: "team joined as admin, is project member")
join_other_member_project = other_as_member_team.projects.create(name: "team joined as member, is project member")
join_other_visitor_project = other_as_visitor_team.projects.create(name: "team joined as visitor, is project member")


join_other_admin_project.project_members.create(user_id: user.id)
join_other_member_project.project_members.create(user_id: user.id)
join_other_visitor_project.project_members.create(user_id: user.id)
