FactoryGirl.define do 
  factory :user, aliases: [:leader, :assigned_user, :author] do
    sequence(:name)  { |n| "persion#{n}" }
    sequence(:email) { |n| "persion#{n}@gmail.com" }
    password 'foobar'
    password_confirmation 'foobar'
  end

  factory :team do 
    leader
    name 'team1'
  end

  factory :project do 
    name 'project1'
    description 'desc for project1'
    team
  end

  factory :todo do
    content 'todo1: get a job'
    assigned_user
    author
    end_time '2014-10-01'
  end
end
