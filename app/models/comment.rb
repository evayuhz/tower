class Comment < ActiveRecord::Base
  validates :content, presence: true
  validates :todo_id, presence: true
  validates :user_id, presence: true

  belongs_to :todo 
  belongs_to :user

  has_many :events, -> { includes :user }, as: :eventable

  attr_accessor :attrs_changed_desc
  before_create :create_created_event_desc
  # before_update :create_updated_event_desc

  private 
    def created_at_desc
      "回复了任务"
    end

    def create_created_event_desc
      self.attrs_changed_desc = []
      if self.new_record?
        self.attrs_changed_desc << created_at_desc
      end
    end

end