module RailsKindeditor
  require 'rails_kindeditor/engine'

  module ActionView::Helpers::AssetTagHelper
    def include_kindeditor
      javascript_include_tag "kindeditor/kindeditor.js", "kindeditor/kindeditor-init.js"
    end
  end
end

