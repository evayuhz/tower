class Comment < ActiveRecord::Base
  include EventProvider
  validates :content, presence: true
  validates :user_id, presence: true

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_many :events, -> { includes :user }, as: :eventable

  event_provider :created_at

end
