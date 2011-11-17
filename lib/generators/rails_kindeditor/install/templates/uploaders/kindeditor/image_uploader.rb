# encoding: utf-8

class Kindeditor::ImageUploader < Kindeditor::AssetUploader

  def extension_white_list
    EXT_NAMES[:image]
  end

end

