class CreateKindeditorAssets < ActiveRecord::Migration
  def self.up
    create_table :kindeditor_assets do |t|
      t.string :asset
      t.string :file_name
      t.integer :file_size
      t.string :file_type
      t.timestamps
    end
  end

  def self.down
    drop_table :kindeditor_assets
  end
end

