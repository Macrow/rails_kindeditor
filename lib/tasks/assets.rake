namespace :kindeditor do
  desc "copy kindeditor into public folder"
  task :assets do
    puts "copying kindeditor into public/assets folder ..."
    dest_path = "#{Rails.root}/public/assets"
    FileUtils.mkdir_p dest_path
    FileUtils.cp_r "#{RailsKindeditor.root_path}/vendor/assets/javascripts/kindeditor/", dest_path
  end
end