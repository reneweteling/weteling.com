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

    location = res['location']
    return head :not_found if location.blank?

    redirect_to location, allow_other_host: true
  end

  # The subdomain only exists to proxy SendGrid tracking links, so keep bots out.
  def robots
    render plain: "User-agent: *\nDisallow: /\n", content_type: 'text/plain'
  end

  def not_found
    head :not_found
  end
end
