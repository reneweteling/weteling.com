class MdInput < Formtastic::Inputs::TextInput
  def input_html_options
    {class: 'md-input'}.merge(super)
  end

  def to_html
    input_wrapping do
      label_html <<
      tiptap_assets <<
      "<div class='editor' id='#{input_html_options[:id]}_editor'>#{builder.text_area(method, input_html_options)}</div>".html_safe
    end
  end

  private

  def tiptap_assets
    return "".html_safe if @template.instance_variable_get(:@_tiptap_loaded)
    @template.instance_variable_set(:@_tiptap_loaded, true)
    (@template.javascript_pack_tag('tiptap_editor') + @template.stylesheet_pack_tag('tiptap_editor')).html_safe
  end
end