module RailsKindeditor
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    desc "Install kindeditor for your application."

    def copy_kindeditor_files
      if ::Rails.version < "3.1.0"
        directory "kindeditor", "public/javascripts/kindeditor"
      else # In Rails3.1, just copy kindeditor_init.js
        template "kindeditor/kindeditor-init.js", "app/assets/javascripts/kindeditor-init.js" 
      end
    end
  end
end