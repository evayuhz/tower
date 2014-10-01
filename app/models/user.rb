class User < ActiveRecord::Base
  validates :name, presence: true, length: { minimum:3, maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum:6 }

  has_secure_password

  has_many :teams, class_name: "Team", foreign_key: 'leader_id', dependent: :destroy

  has_many :team_members, dependent: :destroy
  has_many :join_teams, through: :team_members, source: :team, dependent: :destroy

  TeamMember.roles.each do |role, value|
    has_many "join_as_#{role}_team_members".to_sym, ->{ where(role: value) }, 
                                        class_name: "TeamMember",
                                        foreign_key: "user_id",
                                        dependent: :destroy
    has_many "join_as_#{role}_teams".to_sym, through: "join_as_#{role}_team_members".to_sym
  end

  has_many :project_members, dependent: :destroy
  has_many :projects, through: :project_members, dependent: :destroy

  before_create :create_remember_token

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash_token(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def visiable_teams
    v_teams = [self.teams.collect(&:id), self.join_teams.collect(&:id)]

    Team.where(id: v_teams)
  end

  def visiable_team_projects(team)
    self.projects.where(team_id: team.id)
  end

  def visiable_team_events(team)
    Event.includes(:project, :user, :eventable).where(project_id: visiable_team_projects(team)).order("created_at desc")
  end
  
  private
    def create_remember_token
      self.remember_token = User.hash_token(User.new_remember_token)
    end
end
