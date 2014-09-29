class Todo < ActiveRecord::Base
  include SoftDelete
  validates :content, presence: true
  validates :author_id, presence: true

  enum status: [:new_created, :in_progress, :suspend, :reopened, :completed, :deleted]
  enum priority: [:normal, :high]

  belongs_to :project
  belongs_to :assigned_user, class_name: "User", foreign_key: "assigned_to"
  belongs_to :author, class_name: "User", foreign_key: 'author_id'

  has_many :events, as: :eventable

  default_scope { where.not(status: statuses[:deleted]) }
  scope :incomplete, -> { where.not(status: statuses[:completed]) }

  attr_accessor :attrs_changed_desc
  before_save :create_changed_event_desc

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

    def assigned_desc
      assigned_to_was ? "把#{User.find(assigned_to_was).name}的任务指派给 #{assigned_user.name}" :
                             "给#{assigned_user.name}指派了任务"
    end

    def end_time_desc
       "将任务完成时间从 #{end_time_was ? end_time_was : '没有截止时间' } 修改为 #{end_time_format} "
    end

    def create_changed_event_desc()
      track_attrs = [:created_at, :status, :assigned_to, :end_time]
      self.attrs_changed_desc = []
      track_attrs.each do |attr|
        self.attrs_changed_desc << self.send("#{attr}_desc") if ((attr == :created_at ) ? self.new_record? : self.send("#{attr}_changed?"))
      end
    end
end
