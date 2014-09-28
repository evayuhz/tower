class Todo < ActiveRecord::Base
  validates :content, presence: true
  validates :author_id, presence: true

  enum status: [:new_created, :in_progress, :suspend, :completed, :deleted]
  enum priority: [:normal, :high]

  belongs_to :project
  belongs_to :assigned_user, class_name: "User", foreign_key: "assigned_to"
  belongs_to :author, class_name: "User", foreign_key: 'author_id'

  default_scope { where.not(status: statuses[:deleted]) }
  scope :incomplete, -> { where.not(status: statuses[:completed]) }
end
