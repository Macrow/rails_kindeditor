# encoding: utf-8

class Kindeditor::FileUploader < Kindeditor::AssetUploader

  def extension_white_list
    EXT_NAMES[:file]
  end

end

