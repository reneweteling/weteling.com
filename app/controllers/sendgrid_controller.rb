class SendgridController < ApplicationController
  skip_before_action :verify_authenticity_token

  def email_proxy()
    uri = URI("https://sendgrid.net#{request.fullpath}")
    req = Net::HTTP::Get.new uri
    req['Host'] = 'url462.weteling.com'

    res = Net::HTTP.start(
      uri.host, uri.port,
      use_ssl: uri.scheme == 'https',
      verify_mode: OpenSSL::SSL::VERIFY_NONE
    ) do |http|
      http.request req
    end

    redirect_to res[:location], allow_other_host: true
  end
end
