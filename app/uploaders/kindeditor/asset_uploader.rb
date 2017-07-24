# encoding: utf-8

class Kindeditor::AssetUploader < CarrierWave::Uploader::Base
  
  EXT_NAMES = {:image => RailsKindeditor.upload_image_ext,
               :flash => RailsKindeditor.upload_flash_ext,
               :media => RailsKindeditor.upload_media_ext,
               :file  => RailsKindeditor.upload_file_ext}

  # Include RMagick or ImageScience support:
  # include CarrierWave::RMagick
  # include CarrierWave::ImageScience
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    if Kindeditor::AssetUploader.save_upload_info?
      "#{RailsKindeditor.upload_store_dir}/#{model.asset_type.to_s.underscore.gsub(/(kindeditor\/)|(_uploader)/, '')}/#{model.created_at.strftime("%Y%m")}"
    else
      "#{RailsKindeditor.upload_store_dir}/#{self.class.to_s.underscore.gsub(/(kindeditor\/)|(_uploader)/, '')}/#{Time.now.strftime("%Y%m")}"
    end
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  before :store, :remember_cache_id
  after :store, :delete_tmp_dir

  # store! nil's the cache_id after it finishes so we need to remember it for deletition
  def remember_cache_id(new_file)
    @cache_id_was = cache_id
  end

  def delete_tmp_dir(new_file)
    # make sure we don't delete other things accidentally by checking the name pattern
    if @cache_id_was.present? && @cache_id_was =~ /\A[\d]{8}\-[\d]{4}\-[\d]+\-[\d]{4}\z/
      FileUtils.rm_rf(File.join(cache_dir, @cache_id_was))
    end
  end

  def filename
    if original_filename 
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path)).slice(0, 12)
      "#{@name}.#{file.extension}"
    end
  end
  
  def self.save_upload_info?
    begin
      %w(asset file flash image media).each do |s|
        "Kindeditor::#{s.camelize}".constantize
      end
      return true
    rescue
      return false
    end
  end
  
  def move_to_cache
    false
  end

  def move_to_store
    true
  end

end

