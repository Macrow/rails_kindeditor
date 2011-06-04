module RailsKindeditor
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    desc "Copy kindeditor files to your application."

    def copy_kindeditor_files
      directory "kindeditor", "public/javascripts/"
    end
  end
end

