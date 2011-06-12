module RailsKindeditor
  module Helper
    def include_kindeditor_if_needed
      if @use_kindeditor
        javascript_include_tag "kindeditor/kindeditor.js", "kindeditor/kindeditor-init.js"
      end
    end
  end
end

ActionView::Base.send(:include, RailsKindeditor::Helper)

