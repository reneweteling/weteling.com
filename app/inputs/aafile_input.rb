class AafileInput
  include Formtastic::Inputs::Base

  def to_html
    file = object.send "#{method}"
    
    preview = ""
    if file.present?
      if ['jpg','png', 'gif', 'jpeg'].include? File.extname(file.url.split('?').first).downcase.gsub('.','')
        preview = "<a href=\"#{file.url}\" class=\"upload-link\" target=\"_blank\">
        <img class=\"upload-preview\" src=\"#{file.thumb}\" />
        </a>".html_safe
      else
        preview = "<a href=\"#{file.url}\" class=\"upload-link\" target=\"_blank\">
        #{file.file.filename}
        </a>".html_safe
      end

      remove_field = builder.file_field("remove_#{method}".to_sym, input_html_options.merge({ type: :checkbox, id: "remove_#{input_html_options[:id]}" }) )
      name = /id=\"(.*?)\"/.match(remove_field)[1]
      preview += "<label for=\"#{name}\" class=\"remove-link\">
                    #{remove_field}Remove
                  </label>".html_safe
    end

    
    # cache field for carrierwave
    cache = object.send "#{method}_cache"
    cachefield = builder.file_field("#{method}_cache".to_sym, input_html_options.merge({ type: :hidden, id: "#{input_html_options[:id]}_cache", value: cache }) )


    input_wrapping do
        label_html <<
        "<div class=\"preview-wrapper\">#{builder.file_field(method, input_html_options)}#{cachefield}#{preview}</div>".html_safe
    end
  end
end



