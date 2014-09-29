class Project < ActiveRecord::Base
  validates :name, presence: true
  validates :team_id, presence: true

  belongs_to :team
  has_many :todos, dependent: :destroy
  has_many :project_members, dependent: :destroy
  has_many :members, class_name: "User", foreign_key: "user_id", 
                     through: :project_members, dependent: :destroy

  def visiable?(user)
    # 只有项目成员才能访问项目，即使是项目所在团队的超级管理员或管理员也不到自己没加入的项目
    members.include?(user)
    
    # not used
    # # 是此项目所在团队的超级管理员(leader)
    # # 或是此项目的成员
    # # 或是此项目所在团队的管理员
    # if team.leader == user || members.include?(user)
    #   true
    # elsif team.admin_members.include?(user)
    #   true
    # else
    #   false
    # end
  end
end


