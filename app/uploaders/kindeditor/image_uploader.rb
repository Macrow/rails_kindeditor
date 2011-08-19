# encoding: utf-8

class Kindeditor::ImageUploader < Kindeditor::AssetUploader

  def store_dir
    "uploads/image/#{Time.now.strftime("%Y%m")}"
  end

  def extension_white_list
    EXT_NAMES[:image]
  end

end

