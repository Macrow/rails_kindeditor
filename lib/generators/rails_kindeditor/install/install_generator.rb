module RailsKindeditor
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    desc "Install kindeditor for your application."

    def copy_kindeditor_files
      if ::Rails.version < "3.1.0"
        warn "Warning: rails_kindeditor ~> v0.3.0 only support Rails3.1+!"
        warn "If you're using rails3.0.x, please check rails_kindeditor v0.2.8"
      else
        template "rails_kindeditor.rb", "config/initializers/rails_kindeditor.rb"
      end
    end

    def insert_or_copy_js_files
      if File.exist?('app/assets/javascripts/application.js')
        insert_into_file "app/assets/javascripts/application.js", "//= require jquery\n//= require jquery_ujs\n//= require kindeditor\n", :before => "//= require_tree ."
      else
        copy_file "application.js", "app/assets/javascripts/application.js"
      end
    end

    def copy_load_kindeditor_coffeescript
      if ::Rails.version < "3.1.0"
        warn "Warning: rails_kindeditor ~> v0.3.0 only support Rails3.1+!"
        warn "If you're using rails3.0.x, please check rails_kindeditor v0.2.8"
      else
        template "load_kindeditor.coffee", "app/assets/javascripts/load_kindeditor.coffee"
      end
    end
  end
end
