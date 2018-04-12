#coding: utf-8

class Kindeditor::AssetsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    cls =  Kindeditor::AssetUploader.create_asset_model(params[:dir])
    if cls
      options = {
          asset: params[:imgFile],
          owner_id: params[:owner_id],
          owner_type: params[:owner_type],
          asset_type: params[:dir]
      }.delete_if {|k,v| v.blank?}
      asset = cls.new(options)
      if asset.save
        render json: {error: 0, url: asset.asset.url}
      else
        render json: {error: 1, message: asset.errors.full_messages}
      end
    else
      cls =  Kindeditor::AssetUploader.create_uploader(params[:dir])
      if cls
        uploader = cls.new()
        uploader.store!(params[:imgFile])
        render json: {:error => 0, :url => uploader.url}
      else
        render json: {:error => 1, :message => "can't upload the file for #{params[:dir]} type!"}
      end
    end
  end

  def list
    root_url = File.join('/', RailsKindeditor.upload_store_dir)
    root_url = File.join(root_url, params[:dir]) unless params[:dir].blank?
    root_url.split('/').each do |dir|
      path ||= Rails.public_path
      path = File.join(path, dir)
      Dir.mkdir(path) unless Dir.exist?(path)
    end
    root_url = File.join(root_url, params[:path]) unless params[:path].blank?

    root_path = File.join( Rails.public_path, root_url)
    file_list = []
    Dir.foreach(root_path) do |entry|
      next if (entry == '..' || entry == '.')
      full_path = File.join(root_path, entry)
      file_ext = File.extname(full_path).gsub(/\./,"")
      info = {
          filename: entry,
          datetime: File.mtime(full_path).to_s(:db)
      }
      if File.directory?(full_path)
        info[:is_dir] = true
        info[:has_file] = Dir.entries(full_path).size > 0
        info[:filesize] = 0
        info[:is_photo] = false
        info[:filetype] = ""
      else
        info[:is_dir] = false
        info[:has_file] = false
        info[:filesize] = File.size(full_path)
        info[:dir_path] = ""        
        info[:is_photo] =  Kindeditor::AssetUploader.is_image?(file_ext)
        info[:filetype] = file_ext
      end
      file_list << info
    end
    order = "filename"
    unless params[:order].blank?
      order = params[:order].downcase if %w(filename filesize filetype datetime).include?(params[:order].downcase)
    end

    if order=='datetime'
      file_list.sort! {|a, b| b["#{order}".to_sym] <=> a["#{order}".to_sym]}
    else
      file_list.sort! {|a, b| a["#{order}".to_sym] <=> b["#{order}".to_sym]}
    end

    result = {
        moveup_dir_path: params[:path].gsub(/(.*?)[^\/]+\/$/, ""),
        current_dir_path: params[:path],
        current_url: root_url,
        total_count: file_list.count,
        file_list: file_list
    }
    render json: result
  end

end
