require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

pp ENV

module WetelingCom
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :en
    # config.autoload_paths << Rails.root.join('app', 'graph')
    # config.autoload_paths << Rails.root.join('app', 'graph', 'types')
    config.autoload_paths += Dir[Rails.root.join('app', 'graphql', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**}')]

    config.sass.preferred_syntax = :sass

    config.load_defaults = "6.0"
    config.autoloader = :classic
  end
end


# http://mgiroux.me/2015/getting-started-with-rails-graphql-relay/