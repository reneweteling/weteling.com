InvisibleCaptcha.setup do |config|
  # Reject submissions that come back faster than a human could plausibly fill
  # the form (seconds).
  config.timestamp_threshold = 3

  # Don't blow up if a legit-but-slow page keeps a stale timestamp around.
  config.timestamp_enabled = true
end
