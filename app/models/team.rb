class Team < ActiveRecord::Base
  belongs_to :leader, class_name: 'User', foreign_key: 'leader_id'
end
