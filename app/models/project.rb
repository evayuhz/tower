class Project < ActiveRecord::Base
  validates :name, presence: true
  validates :team_id, presence: true
  validates :author_id, presence: true

  belongs_to :team
  belongs_to :author, class_name: "User"
  has_many :todos, dependent: :destroy
  has_many :project_members, dependent: :destroy
  has_many :members, class_name: "User", foreign_key: "user_id", 
                     through: :project_members, dependent: :destroy

  has_many :events

end


