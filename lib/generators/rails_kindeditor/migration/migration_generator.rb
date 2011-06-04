module RailsKindeditor
  class MigrationGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    desc "Copy model , migration and uploader to your application."

    def copy_model_files
      copy_file "models/asset.rb", "app/models/kindeditor/asset.rb"
      copy_file "models/image.rb", "app/models/kindeditor/image.rb"
      copy_file "models/file.rb", "app/models/kindeditor/file.rb"
    end

    def copy_migration_file
      migration_template "migration.rb", "db/migrate/create_kindeditor_assets.rb"
    end
  end
end

