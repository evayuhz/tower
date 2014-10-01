class Comment < ActiveRecord::Base
  validates :content, presence: true
  validates :todo_id, presence: true
  validates :user_id, presence: true

  belongs_to :todo 
  belongs_to :user
end
