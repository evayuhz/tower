class User < ActiveRecord::Base
  validates :name, presence: true, length: { minimum:3, maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum:6 }

  has_secure_password

  has_many :teams, foreign_key: 'leader_id'
end
