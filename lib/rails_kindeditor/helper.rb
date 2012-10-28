module RailsKindeditor
  module Helper
    def kindeditor_tag(name, content = nil, options = {})
      id = sanitize_to_id(name)
      input_html = { :id => id }.merge(options.delete(:input_html) || {})
      output = ActiveSupport::SafeBuffer.new
      output << text_area_tag(name, content, input_html)
      output << javascript_tag(js_replace(id, options))
    end
    
    def kindeditor(name, method, options = {})
      input_html = (options.delete(:input_html) || {})
      hash = input_html.stringify_keys
      instance_tag = ActionView::Base::InstanceTag.new(name, method, self, options.delete(:object))
      instance_tag.send(:add_default_name_and_id, hash)      
      output_buffer = ActiveSupport::SafeBuffer.new
      output_buffer << instance_tag.to_text_area_tag(input_html)
      js = js_replace(hash['id'], options)
      output_buffer << javascript_tag(js)
    end
    
    private
    def js_replace(dom_id, options = {})
      "KindEditor.ready(function(K){
      	K.create('##{dom_id}', #{get_options(options).to_json});
      });"
    end

    def get_options(options)
      options.delete(:uploadJson)
      options.delete(:fileManagerJson)
      options.reverse_merge!(:width => '100%')
      options.reverse_merge!(:height => 300)
      options.reverse_merge!(:allowFileManager => true)
      options.merge!(:uploadJson => '/kindeditor/upload')
      options.merge!(:fileManagerJson => '/kindeditor/filemanager')
      if options[:simple_mode] == true
        options.delete(:simple_mode)
        options.merge!(:items => %w{fontname fontsize | forecolor hilitecolor bold italic underline removeformat | justifyleft justifycenter justifyright insertorderedlist insertunorderedlist | emoticons image link})
      end
      options
    end    
  end
  
  module Builder
    def kindeditor(method, options = {})
      @template.send("kindeditor", @object_name, method, objectify_options(options))
    end
  end
end