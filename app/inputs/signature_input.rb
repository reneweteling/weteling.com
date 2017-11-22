class SignatureInput
  include Formtastic::Inputs::Base
  include ActionView::Helpers::JavaScriptHelper
  # def builder

  #   vector = object.send "#{method}_vector"
  #   method
  #   object.send method

    
  #   "TEST"
  # end

  def to_html
    png = object.send "#{method}"
    png = png.url if png.kind_of? DefaultUploader

    sig = ''
    sig = "<p>Huidige handtekening</p><img class=\"signature\" src=\"#{png}\" />" if png.present?

    pad = "
    <div class=\"sig-pad\">
      <ul class=\"sigNav\">
        <li class=\"clearButton\"><a href=\"#clear\">Clear</a></li>
      </ul>
      <div class=\"sig \">
        <div class=\"sigWrapper\">
          <div class=\"typed\"></div>
          <canvas class=\"pad\" width=\"400\" height=\"125\" ></canvas>
          #{builder.hidden_field(method, input_html_options.merge(class: :pngoutput, value: png))}
          #{sig}
        </div>
      </div>
    </div>".html_safe

    input_wrapping do
        label_html <<
        pad
    end
  end
end