class MdInput < Formtastic::Inputs::TextInput
  def input_html_options
    {class: 'md-input'}.merge(super)
  end
  
  def to_html

    input_wrapping do
      label_html <<
      "<div class='editor' id='#{input_html_options[:id]}_editor'>#{builder.text_area(method, input_html_options)}</div>".html_safe
    end
  end
 
end