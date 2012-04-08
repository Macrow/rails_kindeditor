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
  end
end