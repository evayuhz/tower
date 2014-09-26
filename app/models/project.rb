class Project < ActiveRecord::Base
  validates :name, presence: true
  validates :team_id, presence: true

  belongs_to :team
  
end
