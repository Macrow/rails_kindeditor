class Kindeditor::Asset < ActiveRecord::Base
  self.table_name = 'kindeditor_assets'
  mount_uploader :asset, AssetUploader
  validates_presence_of :asset
  before_save :update_asset_attributes
  attr_accessible :asset
  
  private
  def update_asset_attributes
    self.file_size = asset.file.size
    self.file_type = asset.file.content_type
  end
end