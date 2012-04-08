require "rails_kindeditor"
require "rails"
require "action_controller"

module RailsKindeditor
  class Engine < Rails::Engine
    
    initializer "rails_kindeditor.assets_precompile" do |app|
      app.config.assets.precompile += RailsKindeditor.assets
    end
    
    initializer "rails_kindeditor.methods" do
      ActionController::Base.send(:include, RailsKindeditor::ControllerAdditions)
    end
    
    initializer "rails_kindeditor.simple_form_and_formtastic" do
      require "rails_kindeditor/simple_form" if Object.const_defined?("SimpleForm")
      require "ckeditor/hooks/formtastic" if Object.const_defined?("Formtastic")
    end
    
    initializer "rails_kindeditor.helper_and_builder" do
      ActiveSupport.on_load :action_view do
        ActionView::Base.send(:include, RailsKindeditor::Helper)
        ActionView::Helpers::FormBuilder.send(:include, RailsKindeditor::Builder)
      end
    end
    
  end
end