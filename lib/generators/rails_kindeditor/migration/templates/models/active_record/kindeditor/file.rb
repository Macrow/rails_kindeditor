class Kindeditor::File < Kindeditor::Asset
  mount_uploader :asset, Kindeditor::FileUploader
end