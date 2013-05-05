module RailsKindeditor
  class MigrationGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)
    desc "Copy model and migration to your application."
    class_option :orm, :type => :string, :aliases => "-o", :default => "active_record", :desc => "ORM options: active_record or mongoid"

    def copy_files
      orm = options[:orm].to_s
      orm = "active_record" unless %w{active_record mongoid}.include?(orm)
      %w(asset file flash image media).each do |file|
        copy_model(orm, file)
      end
      if Rails.version < '4.0.0' && Rails.version >= '3.0.0' # insert code for rails3
        insert_into_file "app/models/kindeditor/asset.rb", "  attr_accessible :asset\n", :after => "before_save :update_asset_attributes\n"
      end
      if orm == "active_record"
        migration_template "migration/migration.rb", "db/migrate/create_kindeditor_assets.rb"
      end
    end

   def self.next_migration_number(dirname)
     if ActiveRecord::Base.timestamped_migrations
       Time.now.utc.strftime("%Y%m%d%H%M%S")
     else
       "%.3d" % (current_migration_number(dirname) + 1)
     end
   end
   
   private
   def copy_model(orm, name)
     template "models/#{orm}/kindeditor/#{name}.rb", "app/models/kindeditor/#{name}.rb"
   end
  end
end

