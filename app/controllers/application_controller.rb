class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :www_redirect
  before_action :set_browser

  rescue_from ActionController::BadRequest do
    head :bad_request
  end

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.html { render file: Rails.public_path.join('404.html'), status: :not_found, layout: false }
      format.any  { head :not_found }
    end
  end

  def health_check
    render text: "true"
  end

  private 

    def set_browser
      @browser = Browser.new(request.user_agent)
    end

    def www_redirect
      if Rails.env.production? && request.host.split('.').count == 2 && !/^www/.match(request.host)
        redirect_to "#{request.scheme}://www.#{request.host}#{request.fullpath}", status: 301, allow_other_host: true
      end
    end
end
