require "rails_kindeditor"
require "rails"
require "action_controller"

module RailsKindeditor
  class Engine < Rails::Engine
    
    initializer "rails_kindeditor.assets_precompile" do |app|
      app.config.assets.precompile += RailsKindeditor.assets
    end
    
    initializer "rails_kindeditor.simple_form_and_formtastic" do
      require "rails_kindeditor/simple_form" if Object.const_defined?("SimpleForm")
      require "rails_kindeditor/formtastic" if Object.const_defined?("Formtastic")
    end
    
    initializer "rails_kindeditor.helper_and_builder" do
      ActiveSupport.on_load :action_view do
        ActionView::Base.send(:include, RailsKindeditor::Helper)
        ActionView::Helpers::FormBuilder.send(:include, RailsKindeditor::Builder)
      end
    end
    
    initializer "rails_kindeditor.image_process" do
      unless RailsKindeditor.image_resize_to_limit.nil?
        Kindeditor::ImageUploader.class_eval do
          include CarrierWave::MiniMagick
          process :resize_to_limit => RailsKindeditor.resize_to_limit
        end
      end
    end
    
  end
end