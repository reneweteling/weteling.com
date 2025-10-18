Recaptcha.configure do |config|
  config.site_key  = ENV['GOOGLE_CAPTCHA_SITE_KEY']
  config.secret_key = ENV['GOOGLE_CAPTCHA_SECRET_KEY']

  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'

  # Uncomment if you want to use the enterprise version
  # config.enterprise = true
  # config.enterprise_api_key = ENV['RECAPTCHA_ENTERPRISE_API_KEY']
end
