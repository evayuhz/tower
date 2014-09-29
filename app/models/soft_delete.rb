module SoftDelete
  def self.included(base)
    base.extend ClassMethods
    base.instance_eval do
      alias_method :destroy!, :destroy
    end
  end

  module ClassMethods
  end

  def destroy
    run_callbacks :destroy do 
      self.deleted!
    end
  end
end

