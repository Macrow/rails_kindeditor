require 'carrierwave/orm/mongoid'       

class Kindeditor::Asset 
  self.collection_name = 'kindeditor_asset'     
  include Mongoid::Document
  include Mongoid::Timestamps
  mount_uploader :asset
  field :file_size, :type => Integer
  field :file_type, :type => String
  validates_presence_of :asset
  before_save :update_asset_attributes

  private
  def update_asset_attributes
    if asset.present? && asset_changed?
      self.content_type = asset.file.content_type
      self.file_size = asset.file.size
    end
  end
end
