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

  has_many :comments

  # default_scope { where.not(status: statuses[:deleted]) }
  scope :incomplete, -> { where.not(status: [statuses[:completed], statuses[:deleted] ]) }

  event_provider :created_at, :status, :end_time, :assigned_to

  # include todo events and comments event
  def all_events
    todo_and_comment_events = [self.events, self.comments.collect{ |c| c.events } ].flatten

    Event.includes(:project, :user, :eventable).where(id: todo_and_comment_events).order("created_at desc")
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
    def created_at_desc
      "创建了任务"
    end

    def status_desc
      return "开始处理这条任务" if in_progress?
      return "完成了任务" if completed?
      return "删除了任务" if deleted?
      return "重新打开了任务" if reopened?
    end

    def assigned_to_desc
      assigned_to_was ? "把#{User.find(assigned_to_was).name}的任务指派给 #{assigned_user.name}" :
                             "给#{assigned_user.name}指派了任务"
    end

    def end_time_desc
       "将任务完成时间从 #{end_time_was ? end_time_was : '没有截止时间' } 修改为 #{end_time_format} "
    end

end
