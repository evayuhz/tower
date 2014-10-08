class Todo < ActiveRecord::Base
  include SoftDelete
  include EventProvider
  validates :content, presence: true
  validates :author_id, presence: true

  enum status: [:new_created, :in_progress, :suspend, :reopened, :completed, :deleted]
  enum priority: [:normal, :high]

  belongs_to :project
  belongs_to :assigned_user, class_name: "User", foreign_key: "assigned_to"
  belongs_to :author, class_name: "User", foreign_key: 'author_id'

  has_many :events, -> { includes :user }, as: :eventable

  has_many :comments, -> { includes :user }, as: :commentable

  # default_scope { where.not(status: statuses[:deleted]) }
  scope :incomplete, -> { where.not(status: [statuses[:completed], statuses[:deleted] ]) }

  event_provider :created_at, :status, :end_time, :assigned_to

  # include todo events and comments event
  def all_events
    todo_and_comment_events = [self.events, self.comments.collect{ |c| c.events } ].flatten

    Event.includes(:project, :user, :eventable).where(id: todo_and_comment_events).order("created_at asc")
  end

  def assigned_user_name
    self.assigned_to ? self.assigned_user.name : "未指派"
  end

  def end_time_format
    self.end_time ? self.end_time : "没有截止时间"
  end

  def assigned_and_end_time_info
    "#{assigned_user_name} #{end_time_format}"
  end

  def delay?
    if self.end_time
      return self.end_time < Time.now
    end
    false
  end

  private
    def created_at_event_content(change)
      { action: :created_todo_event }
    end

    def status_event_content(change)
      return { action: :deleted_todo_event } if self.deleted?
      return { action: :completed_todo_event } if self.completed?
      return { action: :reopened_todo_event } if self.reopened?
    end

    def assigned_to_event_content(change)
      if change[:old_value]
        { action: :change_assigned_to_todo_event, old_user: User.find(change[:old_value]).name , 
                                                  new_user: User.find(change[:new_value]).name }
      else
        { action: :set_assigned_to_todo_event, user: User.find(change[:new_value]).name }
      end
    end

    def end_time_event_content(change)
      if change[:old_value]
        { action: :change_end_time_todo_event, old_date: change[:old_value], new_date: change[:new_value] }
      else
        { action: :set_end_time_todo_event, date: change[:new_value] }
      end
    end

end
