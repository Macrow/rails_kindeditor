module RailsKindeditor
  module Helper
    def include_kindeditor_if_needed
      if @use_kindeditor
        output = ""
        if ::Rails.version < "3.1.0"
          path = "/javascripts"
        else # Rails3.1+
          path = ""
        end
        if config.perform_caching && ::Rails.version < "3.1.0"
          output << javascript_include_tag("#{path}/kindeditor/kindeditor-min.js", "#{path}/kindeditor/kindeditor-init.js", :cache => "kindeditor/kindeditor-cache")
        else
          output << javascript_include_tag("#{path}/kindeditor/kindeditor-min.js", "#{path}/kindeditor/kindeditor-init.js")
        end
        output.html_safe
      end
    end
  end
end

ActionView::Base.send(:include, RailsKindeditor::Helper)

