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
    config.i18n.default_locale = :en
    # config.autoload_paths << Rails.root.join('app', 'graph')
    # config.autoload_paths << Rails.root.join('app', 'graph', 'types')
    config.autoload_paths += Dir[Rails.root.join("app", "models", "{**}")]

    config.sass.preferred_syntax = :sass
    config.active_storage.service = :amazon

    config.load_defaults = "6.0"
  end
end
