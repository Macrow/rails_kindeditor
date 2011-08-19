# encoding: utf-8

class Kindeditor::FlashUploader < Kindeditor::AssetUploader

  def store_dir
    "uploads/flash/#{Time.now.strftime("%Y%m")}"
  end

  def extension_white_list
    EXT_NAMES[:flash]
  end

end

