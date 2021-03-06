Rails.application.configure do 
  # Mail config
  # config.action_mailer.asset_host                           = "https://#{ENV['ASSET_HOST']}"
  # config.action_mailer.default_url_options                  = {host: "www.#{ENV['DOMAIN']}", protocol:"https"}
  config.action_mailer.delivery_method                      = :smtp
  config.action_mailer.smtp_settings                        = {}
  config.action_mailer.smtp_settings[:address]              = ENV['SMTP_ADDRESS']   if ENV['SMTP_ADDRESS'].present?
  config.action_mailer.smtp_settings[:port]                 = ENV['SMTP_PORT']      if ENV['SMTP_PORT'].present?
  config.action_mailer.smtp_settings[:domain]               = ENV['SMTP_DOMAIN']    if ENV['SMTP_DOMAIN'].present?
  config.action_mailer.smtp_settings[:user_name]            = ENV['SMTP_USER']      if ENV['SMTP_USER'].present?
  config.action_mailer.smtp_settings[:password]             = ENV['SMTP_PASS']      if ENV['SMTP_PASS'].present?
  config.action_mailer.smtp_settings[:authentication]       = ENV['SMTP_AUTH']      if ENV['SMTP_AUTH'].present?
  config.action_mailer.smtp_settings[:enable_starttls_auto] = ENV['SMTP_STARTTLS']  if ENV['SMTP_STARTTLS'].present?
  config.action_mailer.smtp_settings[:openssl_verify_mode]  = ENV['SMTP_OPENSSL_VERIFY_MODE']  if ENV['SMTP_OPENSSL_VERIFY_MODE'].present?
end