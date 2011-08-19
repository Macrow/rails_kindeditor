class Kindeditor::Asset < ActiveRecord::Base
  set_table_name "kindeditor_assets"
  validates_presence_of :asset
  before_save :update_asset_attributes
  
  private
  def update_asset_attributes
    self.file_size = asset.file.size
    self.file_type = asset.file.content_type
  end
end