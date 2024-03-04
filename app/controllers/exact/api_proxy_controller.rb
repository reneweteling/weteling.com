module Exact
  class ApiProxyController < BaseController
    def get()
      path = request
        .fullpath
        .sub('/exact/api', '')
        .sub('$top=100', '$top=1')

      ## excel omits the $top parameter, so we add it here
      # unless path.include?('$top')
      #   path += path.include?('?') ? '&$top=1' : '?$top=1'
      # end

      data = exact.get(path)


      if data.is_a?(Hash)
        render json: replace_endpoints(data)
      else
        data.body.sub!(Client::API, 'http://localhost:3000/exact/api')

        response.headers['Content-Type'] = data.content_type
        render plain: data.body, status: data.code
      end
    end

    def replace_endpoints(data)
      case data.class.to_s
      when 'Array'
        data.map { |d| replace_endpoints(d) }
      when 'Hash'
        data.map { |k, v| [k.underscore, replace_endpoints(v)] }.to_h
      when 'String'
        data.sub(Client::API, 'http://localhost:3000/exact/api')
      else
        data
      end
    end
  end
end

# https://start.exactonline.nl/docs/HlpRestAPIResources.aspx?SourceAction=10
# http://localhost:3000/exact/api/v1/3710230/system/
# http://localhost:3000/exact/api/v1/3710230/bulk/Financial
