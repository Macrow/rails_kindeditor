module RailsKindeditor
  module Helper
    def kindeditor_tag(name, content = nil, options = {})
      id = sanitize_to_id(name)
      input_html = { :id => id }.merge(options.delete(:input_html) || {})
      input_html[:class] = "#{input_html[:class]} rails_kindeditor"
      output = ActiveSupport::SafeBuffer.new
      output << text_area_tag(name, content, input_html)
      output << javascript_tag(js_replace(id, options))
    end
    
    def kindeditor(name, method, options = {})
      # TODO: Refactory options: 1. kindeditor_option 2. html_option
      input_html = (options.delete(:input_html) || {}).stringify_keys
      output_buffer = ActiveSupport::SafeBuffer.new
      output_buffer << build_text_area_tag(name, method, self, merge_assets_info(options), input_html)
      output_buffer << javascript_tag(js_replace(input_html['id'], options))
    end
    
    def merge_assets_info(options)
      owner = options.delete(:owner)
      options[:class] = "#{options[:class]} rails_kindeditor"
      if Kindeditor::AssetUploader.save_upload_info? && (!owner.nil?) && (!owner.id.nil?)
        begin
          owner_id = owner.id
          owner_type = owner.class.name
          options.reverse_merge!(owner_id: owner_id, owner_type: owner_type, data: {upload: kindeditor_upload_json_path(owner_id: owner_id, owner_type: owner_type), filemanager: kindeditor_file_manager_json_path})
          return options
        end
      else
        options.reverse_merge!(data: {upload: kindeditor_upload_json_path, filemanager: kindeditor_file_manager_json_path})
      end
    end
    
    def kindeditor_upload_json_path(*args)
      options = args.extract_options!
      owner_id_query_string = options[:owner_id] ? "?owner_id=#{options[:owner_id]}" : ''
      owner_type_query_string = options[:owner_type] ? "&owner_type=#{options[:owner_type]}" : ''
      if owner_id_query_string == '' && owner_type_query_string == ''
        "#{main_app_root_url}kindeditor/upload"
      else
        "#{main_app_root_url}kindeditor/upload#{owner_id_query_string}#{owner_type_query_string}"
      end
    end
    
    def kindeditor_file_manager_json_path
      "#{main_app_root_url}kindeditor/filemanager"
    end
    
    private
    
    def main_app_root_url
      begin
        main_app.root_url.slice(0, main_app.root_url.rindex(main_app.root_path)) + '/'
      rescue
        '/'
      end
    end
    
    def js_replace(dom_id, options = {})
      editor_id = options[:editor_id].nil? ? '' : "#{options[:editor_id].to_s.downcase} = "
      if options[:window_onload]
        require 'securerandom'
        random_name = SecureRandom.hex;
        "var old_onload_#{random_name};
        if(typeof window.onload == 'function') old_onload_#{random_name} = window.onload;
        window.onload = function() {
          KindEditor.basePath='#{RailsKindeditor.base_path}';
          #{editor_id}KindEditor.create('##{dom_id}', #{get_options(options).to_json});
          if(old_onload_#{random_name}) old_onload_#{random_name}();
        }"
      else
        "KindEditor.basePath='#{RailsKindeditor.base_path}';
        KindEditor.ready(function(K){
        	#{editor_id}K.create('##{dom_id}', #{get_options(options).to_json});
        });"
      end
    end

    def get_options(options)
      options.delete(:editor_id)
      options.delete(:window_onload)
      options.reverse_merge!(:width => '100%')
      options.reverse_merge!(:height => 300)
      options.reverse_merge!(:allowFileManager => true)
      options.reverse_merge!(:uploadJson => kindeditor_upload_json_path(:owner_id => options.delete(:owner_id), :owner_type => options.delete(:owner_type)))
      options.reverse_merge!(:fileManagerJson => kindeditor_file_manager_json_path)
      if options[:simple_mode] == true
        options.merge!(:items => %w{fontname fontsize | forecolor hilitecolor bold italic underline removeformat | justifyleft justifycenter justifyright insertorderedlist insertunorderedlist | emoticons image link})
      end
      options.delete(:simple_mode)
      options
    end
    
    def build_text_area_tag(name, method, template, options, input_html)
      if Rails.version >= '4.0.0'
        text_area_tag = ActionView::Helpers::Tags::TextArea.new(name, method, template, options)
        text_area_tag.send(:add_default_name_and_id, input_html)
        text_area_tag.render
      elsif Rails.version >= '3.1.0'
        text_area_tag = ActionView::Base::InstanceTag.new(name, method, template, options.delete(:object))
        text_area_tag.send(:add_default_name_and_id, input_html)
        text_area_tag.to_text_area_tag(input_html)
      elsif Rails.version >= '3.0.0'
        raise 'Please use rails_kindeditor v0.2.8 for Rails v3.0.x'
      else
        raise 'Please upgrade your Rails !'
      end
    end
  end
  
  module Builder
    def kindeditor(method, options = {})
      @template.send("kindeditor", @object_name, method, objectify_options(options))
    end
  end
end