module EventProvider
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def event_provider(*attrs)
      class_eval do 
        attr_accessor :changed_attrs
        cattr_accessor :track_attrs
      end
      
      self.track_attrs = attrs
      if self.track_attrs.delete(:created_at)
        class_eval do 
          before_create :create_created_event
        end
      end
      if self.track_attrs.any?
        class_eval do 
          before_update :create_updated_events
        end
      end
    end
  end

  # change format: [changed_attr, old_value, new_value]
  def create_created_event
    self.changed_attrs = []
    if self.new_record?
      self.changed_attrs << [:created_at, nil, nil]
    end
  end

  def create_updated_events
    self.changed_attrs = []
    self.track_attrs.each do |attr|
      self.changed_attrs <<  [attr, self.send("#{attr}_was"), self.send("#{attr}") ] if self.send("#{attr}_changed?")
    end
  end

end

