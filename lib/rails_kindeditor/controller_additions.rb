module RailsKindeditor
  module ControllerAdditions
    module ClassMethods
      def include_kindeditor(options = {})
        proc = Proc.new do |c|
          c.instance_variable_set(:@use_kindeditor, true)
        end
        before_filter(proc, options)
      end
    end

    def self.included(base)
      base.extend ClassMethods
    end
  end
end

if defined? ActionController
  ActionController::Base.class_eval do
    include RailsKindeditor::ControllerAdditions
  end
end

