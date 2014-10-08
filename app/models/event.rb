class Event < ActiveRecord::Base
  serialize :content, Hash
  belongs_to :eventable, polymorphic: true
  scope :todo_events, ->{ where(eventable_type: "Todo") }
  belongs_to :project
  belongs_to :user

end
