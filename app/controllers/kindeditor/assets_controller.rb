class Kindeditor::AssetsController < ApplicationController

  def create
    @asset_params = params[:imgFile]
    case @asset_params.content_type.gsub(/\/[a-z]*/, "")
    when 'image'
      @asset = Kindeditor::Image.new(:asset => @asset_params)
      if @asset.save
        render :text => ({:error => 0, :url => @asset.asset.url}.to_json)
      else
        render :text => ({:error => 1, :message => @asset.errors.full_messages}.to_json)
      end
    else # other type files
      @asset = Kindeditor::File.new(:asset => params[:imgFile])
      if @asset.save
        str = "<script type='text/javascript'>parent.KE.plugin['accessory'].insert('" \
              + request[:id] + "', '" + @asset.asset.url + "','" + @asset.asset.filename \
              + "','" + File.extname(@asset.asset.to_s).gsub(".","") + "');</script>"
        render :text => str
      else
        render :nothing => true
      end
    end
  end

  def list
    order = case params[:order]
            when "NAME"
              "asset"
            when "TYPE"
              "file_type"
            when "SIZE"
              "file_size"
            else
              "id"
            end
    @images = Image.where("file_type LIKE '%image%'").order(order).all
    @json = []
    for image in @images
      temp = %Q{{"filesize":#{image.file_size},
                 "filename":"#{image.asset.to_s}",
                 "dir_path":"#{image.asset.url}",
                 "datetime":"#{image.created_at.to_date}"}}
      @json << temp
    end
    render :text => ("{\"file_list\":[" << @json.join(",") << "]}")
  end

end

