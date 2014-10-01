class TeamMember < ActiveRecord::Base
  belongs_to :member, class_name: "User", foreign_key: "user_id"
  belongs_to :team

  enum role: [:admin, :member, :visitor]

  roles.each do |role, value|
    belongs_to "#{role}_member".to_sym, class_name: "User", foreign_key: "user_id"
    belongs_to "join_as_#{role}_team".to_sym, class_name: "Team", foreign_key: "team_id"
  end
end
