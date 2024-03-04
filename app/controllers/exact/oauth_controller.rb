module Exact
  class OauthController < BaseController
    def authorize
      redirect_to exact.authorize_url, allow_other_host: true
    end

    def callback
      code = params[:code]
      # CGI.parse(URI.parse(url).query)['code'].first
      exact.authenticate(code)

      render json: exact.auth_token
    end

  end
end
