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

# team member
team.members << other


# projects and todos: self team's projects and todos 
team.projects.create([{name: 'project1', description: 'desc for project1, own', author_id: user.id}, 
                      {name: 'project2', description: 'desc for project2, not joined', author_id: other.id},
                      {name: 'project3', description: 'desc for project3, joined', author_id: other.id}])
own_project = Project.first
not_joined_project = Project.second
joined_project = Project.find(3)
joined_project.members << user

own_project.todos.create(content: 'todo1: get a job', assigned_to: user.id, author_id: user.id, end_time: '2014-9-25')
Todo.statuses.each do |status, value|
  own_project.todos.create!(content: "#{status}", status: value, author_id: user.id)
end

# project member
own_project.members << other
not_joined_project.members << other


# other team's project 
other_admin_project = other_as_admin_team.projects.create(name: "team joined as admin, not project member", author_id: other.id)
other_member_project = other_as_member_team.projects.create(name: "team joined as member, not project member", author_id: other.id)
other_visitor_project = other_as_visitor_team.projects.create(name: "team joined as visitor, not project member", author_id: other.id)
join_other_admin_project = other_as_admin_team.projects.create(name: "team joined as admin, is project member", author_id: other.id)
join_other_member_project = other_as_member_team.projects.create(name: "team joined as member, is project member", author_id: other.id)
join_other_visitor_project = other_as_visitor_team.projects.create(name: "team joined as visitor, is project member", author_id: other.id)


join_other_admin_project.project_members.create(user_id: user.id)
join_other_member_project.project_members.create(user_id: user.id)
join_other_visitor_project.project_members.create(user_id: user.id)

# joined projects events
todo1 = own_project.todos.first
todo2 = joined_project.todos.create(content: "joined project's todo", author_id: other.id)

4.downto(0) do |n| #day
  10.downto(1) do |t| #times
    todo1.events.create(changed_attr: :status, old_value: Todo.statuses[:reopened], new_value: Todo.statuses[:completed],
                        user_id: user.id, project_id: todo1.project.id, created_at: n.days.ago - (4*t).minutes )
    todo1.events.create(changed_attr: :status, old_value: Todo.statuses[:completed], new_value: Todo.statuses[:reopened],
                        user_id: other.id, project_id: todo1.project.id, created_at: n.days.ago - (4*t -1).minutes )
    todo2.events.create(changed_attr: :status, old_value: Todo.statuses[:reopened], new_value: Todo.statuses[:completed],
                        user_id: user.id, project_id: todo2.project.id, created_at: n.days.ago - (4*t -2).minutes )
    todo2.events.create(changed_attr: :status, old_value: Todo.statuses[:completed], new_value: Todo.statuses[:reopened],
                        user_id: other.id, project_id: todo2.project.id, created_at: n.days.ago - (4*t - 3).minutes )
  end
end

# other project events
todo = not_joined_project.todos.create(content: "not joined project's todo", author_id: other.id)
100.downto(1) do |n|
  todo.events.create(changed_attr: :status, old_value: Todo.statuses[:reopened], new_value: Todo.statuses[:completed],
                     user_id: other.id, project_id: todo.project.id )
  todo.events.create(changed_attr: :status, old_value: Todo.statuses[:completed], new_value: Todo.statuses[:reopened],
                     user_id: other.id, project_id: todo.project.id )
end

