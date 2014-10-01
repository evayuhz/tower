module EventProvider
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def event_provider(*attrs)
      class_eval do 
        attr_accessor :attrs_changed_desc
        cattr_accessor :track_attrs
      end
      
      self.track_attrs = attrs
      if self.track_attrs.delete(:created_at)
        class_eval do 
          before_create :create_created_event_desc
        end
      end
      if self.track_attrs.any?
        class_eval do 
          before_update :create_updated_event_desc
        end
      end
    end
  end

  def create_created_event_desc
    self.attrs_changed_desc = []
    if self.new_record?
      self.attrs_changed_desc << created_at_desc
    end
  end

  def create_updated_event_desc
    self.attrs_changed_desc = []
    self.track_attrs.each do |attr|
      self.attrs_changed_desc << self.send("#{attr}_desc") if self.send("#{attr}_changed?")
    end
  end

end

