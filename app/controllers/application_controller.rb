class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_browser

  def health_check
    render text: "true"
  end

  def set_browser
    @browser = Browser.new(request.user_agent)
  end
end
