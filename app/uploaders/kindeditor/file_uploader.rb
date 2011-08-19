# encoding: utf-8

class Kindeditor::FileUploader < Kindeditor::AssetUploader

  def store_dir
    "uploads/file/#{Time.now.strftime("%Y%m")}"
  end

  def extension_white_list
    EXT_NAMES[:file]
  end

end

