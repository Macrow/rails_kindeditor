# encoding: utf-8

class Kindeditor::FlashUploader < Kindeditor::AssetUploader

  def extension_white_list
    EXT_NAMES[:flash]
  end

end

