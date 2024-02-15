Sentry.init do |config|
  config.dsn = 'https://559fe397554f411d8b4b059c85548d15@glitchtip.weteling.com/4'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
end
