# encoding: utf-8

class Kindeditor::MediaUploader < Kindeditor::AssetUploader

  def store_dir
    "uploads/media/#{Time.now.strftime("%Y%m")}"
  end

  def extension_white_list
    EXT_NAMES[:media]
  end

end

