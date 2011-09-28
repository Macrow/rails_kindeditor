module RailsKindeditor
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    desc "Install kindeditor for your application."

    def copy_kindeditor_files
      if ::Rails.version < "3.1.0"
        directory "kindeditor", "public/javascripts/kindeditor"
      else # Rails3.1+
        directory "kindeditor", "public/kindeditor"
      end
    end
  end
end