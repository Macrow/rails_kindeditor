# encoding: utf-8

class Kindeditor::MediaUploader < Kindeditor::AssetUploader

  def extension_white_list
    EXT_NAMES[:media]
  end

end

