class Kindeditor::Image < Kindeditor::Asset
  mount_uploader :asset, Kindeditor::ImageUploader
end