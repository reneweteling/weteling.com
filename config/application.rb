require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WetelingCom
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :nl
    # config.autoload_paths << Rails.root.join('app', 'graph')
    # config.autoload_paths << Rails.root.join('app', 'graph', 'types')
    config.autoload_paths += Dir[Rails.root.join("app", "models", "{**}")]

    config.asset_host = ENV['HOST'] || 'https://www.weteling.com'
    config.action_controller.asset_host = ENV['HOST'] || 'https://www.weteling.com'

    config.sass.preferred_syntax = :sass
    config.generators.javascript_engine = :js

    config.load_defaults 7.0

    config.action_cable.mount_path = '/websocket'
    config.action_cable.allowed_request_origins = [/http:\/\/*/, /https:\/\/*/, /.*/, nil]
  end
end
