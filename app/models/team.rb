class Team < ActiveRecord::Base
  validates :name, presence: true
  validates :leader_id, presence: true
  belongs_to :leader, class_name: 'User', foreign_key: 'leader_id'

  has_many :projects, dependent: :destroy

  has_many :team_members, dependent: :destroy
  has_many :members, class_name: "User", foreign_key: "user_id", 
                     through: :team_members, dependent: :destroy


  TeamMember.roles.each do |role, value|
    has_many "join_as_#{role}_team_members".to_sym, ->{ where(role: value) }, 
                                        class_name: "TeamMember",
                                        foreign_key: "team_id",
                                        dependent: :destroy
    has_many "#{role}_members".to_sym, through: "join_as_#{role}_team_members".to_sym
  end

  def visiable?(user)
    # leader 和 team 成员(管理员，成员，访客)可见
    leader == user || members.include?(user)
  end

  def visiable_projects(user)
    projects.select { |p| p.visiable?(user) } 
  end

end
