class Event < ActiveRecord::Base
  belongs_to :eventable, polymorphic: true
  scope :todo_events, ->{ where(eventable_type: "Todo") }
  belongs_to :project
  belongs_to :user

  def description
    eable = self.eventable
    if eable.class == Todo 
      case self.changed_attr
      when "created_at"
        return "创建了任务"
      when "status"
        return "开始处理这条任务" if self.new_value.to_i == Todo.statuses[:in_progress]
        return "完成了任务" if self.new_value.to_i == Todo.statuses[:completed]
        return "删除了任务" if self.new_value.to_i == Todo.statuses[:deleted]
        return "重新打开了任务" if self.new_value.to_i == Todo.statuses[:reopened]
      when "end_time"
        return "将任务完成时间从 #{self.old_value ? self.old_value : '没有截止时间'} 修改为 #{self.new_value} "
      when "assigned_to"
        return self.old_value ? "把#{User.find(self.old_value).name}的任务指派给 #{User.find(self.new_value).name}" :
                             "给#{User.find(self.new_value).name}指派了任务"
      end
    elsif eable.class == Comment
      case self.changed_attr
      when "created_at"
        return "回复了任务"
      end
    elsif eable.class == Project
      # some project events like create/delete project and so on
    end
      
      
  end
end
