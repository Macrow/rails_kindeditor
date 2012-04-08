require "formtastic"

class KindeditorInput
  include ::Formtastic::Inputs::Base
  
  def to_html
    input_wrapping do
      label_html <<
      builder.kindeditor(method, input_html_options)
    end
  end
end
