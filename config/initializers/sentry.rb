Sentry.init do |config|
  config.dsn = 'https://1a1767b8b1bbe998f0e6e630dcce3783@o157871.ingest.us.sentry.io/4511585502887936'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Add data like request headers and IP for users,
  # see https://docs.sentry.io/platforms/ruby/data-management/data-collected/ for more info
  config.send_default_pii = true
end
