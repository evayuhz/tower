class User < ActiveRecord::Base
  validates :name, presence: true, length: { minimum:3, maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum:6 }

  has_secure_password

  has_many :teams, class_name: "Team", foreign_key: 'leader_id', dependent: :destroy

  TeamMember.roles.each do |role, value|
    has_many "join_as_#{role}_team_members".to_sym, ->{ where(role: value) }, 
                                        class_name: "TeamMember",
                                        foreign_key: "user_id",
                                        dependent: :destroy
    has_many "join_as_#{role}_teams".to_sym, through: "join_as_#{role}_team_members".to_sym
  end

  has_many :project_members, dependent: :destroy
  has_many :projects, through: :teams, dependent: :destroy


  before_create :create_remember_token

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  private
    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end
