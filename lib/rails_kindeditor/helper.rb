module RailsKindeditor
  module Helper
    def include_kindeditor_if_needed(*sources)
      if @use_kindeditor
        options = sources.extract_options!.stringify_keys
        lang  = options.delete("lang").to_s
        cache  = options.delete("cache").to_s
        lang = %w(en zh_CN zh_TW).include?(lang) ? lang : "zh_CN"
        cache_name = (cache == "true" ? "kindeditor-cache" : "kindeditor-#{cache}")
        output = ""
        output << stylesheet_link_tag("/javascripts/kindeditor/themes/default/default.css") << "\n"
        if config.perform_caching && !cache.empty?
          output << javascript_include_tag("/javascripts/kindeditor/kindeditor-min.js", "/javascripts/kindeditor/lang/#{lang}.js", "/javascripts/kindeditor/kindeditor-init.js", :cache => "kindeditor/#{cache_name}")
        else
          output << javascript_include_tag("/javascripts/kindeditor/kindeditor-min.js", "/javascripts/kindeditor/lang/#{lang}.js", "/javascripts/kindeditor/kindeditor-init.js")
        end
        output.html_safe
      end
    end
  end
end

ActionView::Base.send(:include, RailsKindeditor::Helper)

