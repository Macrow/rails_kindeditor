module RailsKindeditor
  module SimpleForm
    class KindeditorInput < ::SimpleForm::Inputs::Base
      def input(wrapper_options)
        @builder.kindeditor(attribute_name, input_html_options)
      end
    end
  end
end

::SimpleForm::FormBuilder.map_type :kindeditor, :to => RailsKindeditor::SimpleForm::KindeditorInput