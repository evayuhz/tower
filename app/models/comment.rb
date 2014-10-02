class Comment < ActiveRecord::Base
  include EventProvider
  validates :content, presence: true
  validates :todo_id, presence: true
  validates :user_id, presence: true

  belongs_to :todo 
  belongs_to :user

  has_many :events, -> { includes :user }, as: :eventable

  event_provider :created_at

end
