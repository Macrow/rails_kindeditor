#coding: utf-8
require "find"
class Kindeditor::AssetsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @imgFile, @dir = params[:imgFile], params[:dir]
    unless @imgFile.nil?
      if Kindeditor::AssetUploader.save_upload_info? # save upload info into database
        begin
          @asset = "Kindeditor::#{@dir.camelize}".constantize.new(:asset => @imgFile)
          @asset.owner_id = params[:owner_id] ? params[:owner_id] : 0
          @asset.owner_type = params[:owner_type] ? params[:owner_type] : ''
          logger.warn '========= Warning: the owner have not been created, "delete uploaded files automatically" will not work. =========' if defined?(logger) && @asset.owner_id == 0
          @asset.asset_type = @dir
          if @asset.save
            render :plain => ({:error => 0, :url => @asset.asset.url}.to_json)
          else
            show_error(@asset.errors.full_messages)
          end
        rescue Exception => e
          show_error(e.to_s)
        end
      else # do not touch database
        begin
          uploader = "Kindeditor::#{@dir.camelize}Uploader".constantize.new
          uploader.store!(@imgFile)
          render :plain => ({:error => 0, :url => uploader.url}.to_json)
        rescue CarrierWave::UploadError => e
          show_error(e.message)
        rescue Exception => e
          show_error(e.to_s)
        end
      end
    else
      show_error("No File Selected!")
    end
  end

  def list
    @root_path = "#{Rails.public_path}/#{RailsKindeditor.upload_store_dir}/"
    @root_url = "/#{RailsKindeditor.upload_store_dir}/"
    @img_ext = Kindeditor::AssetUploader::EXT_NAMES[:image]
    @dir = params[:dir].strip || ""
    unless Kindeditor::AssetUploader::EXT_NAMES.keys.map(&:to_s).push("").include?(@dir)
      render :plain => "Invalid Directory name."
      return
    end
    
    upload_path = Rails.public_path
    RailsKindeditor.upload_store_dir.split('/').each do |dir|
      upload_path += dir
      Dir.mkdir(upload_path) unless Dir.exist?(upload_path)      
    end    
       
    @root_path += @dir + "/"
    @root_url += @dir + "/"
    
    Dir.mkdir(@root_path) unless Dir.exist?(@root_path)
    
    @path = params[:path].strip || ""
    if @path.empty?
      @current_path = @root_path
      @current_url = @root_url
      @current_dir_path = ""
      @moveup_dir_path = ""
    else
      @current_path = @root_path + @path + "/"      
      @current_url = @root_url + @path + "/"
      @current_dir_path = @path
      @moveup_dir_path = @current_dir_path.gsub(/(.*?)[^\/]+\/$/, "")
    end
    @order = %w(name size type).include?(params[:order].downcase) ? params[:order].downcase : "name"
    if !@current_path.match(/\.\./).nil?
      render :plain => "Access is not allowed."
      return
    end
    if @current_path.match(/\/$/).nil?
      render :plain => "Parameter is not valid."
      return
    end
    if !File.exist?(@current_path) || !File.directory?(@current_path)
      render :plain => "Directory does not exist."
      return
    end
    @file_list = []
    Dir.foreach(@current_path) do |filename|  
      hash = {}
      if filename != "." and filename != ".." and filename != ".DS_Store"
        file = @current_path + filename
        if File.directory?(file)
          hash[:is_dir] = true
          hash[:has_file] = (Dir.foreach(file).count > 2)
          hash[:filesize] = 0
          hash[:is_photo] = false
          hash[:filetype] = ""
        else
          hash[:is_dir] = false
          hash[:has_file] = false
          hash[:filesize] = File.size(file)
          hash[:dir_path] = ""
          file_ext = file.gsub(/.*\./,"")
          hash[:is_photo] = @img_ext.include?(file_ext)
          hash[:filetype] = file_ext
        end
        hash[:filename] = filename
        hash[:datetime] = File.mtime(file).to_s(:db)
        @file_list << hash
      end
    end

    @file_list.sort! {|a, b| a["file#{@order}".to_sym] <=> b["file#{@order}".to_sym]}
    
    @result = {}
    @result[:moveup_dir_path] = @moveup_dir_path
    @result[:current_dir_path] = @current_dir_path
    @result[:current_url] = @current_url
    @result[:total_count] = @file_list.count
    @result[:file_list] = @file_list
    render :plain => @result.to_json
  end
  
  private
  def show_error(msg)
    render :plain => ({:error => 1, :message => msg}.to_json)
  end
  
end
