require 'rails/generators/active_record'

module RailsKindeditor
  class MigrationGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    desc "Copy models uploaders and migration to your application."

    def copy_model_files
      copy_file "models/asset.rb", "app/models/kindeditor/asset.rb"
      copy_file "models/image.rb", "app/models/kindeditor/image.rb"
      copy_file "models/file.rb", "app/models/kindeditor/file.rb"
      copy_file "uploaders/image_uploader.rb", "app/uploaders/image_uploader.rb"
      copy_file "uploaders/file_uploader.rb", "app/uploaders/file_uploader.rb"
    end

    def copy_migration_file
      migration_template "migration.rb", "db/migrate/create_kindeditor_assets.rb"
    end
  end
end

