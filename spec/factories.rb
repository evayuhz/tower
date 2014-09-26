FactoryGirl.define do 
  factory :user, aliases: [:leader] do
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
end
