class Team < ActiveRecord::Base
  validates :name, presence: true
  validates :leader_id, presence: true
  belongs_to :leader, class_name: 'User', foreign_key: 'leader_id'

  has_many :projects, dependent: :destroy
end
