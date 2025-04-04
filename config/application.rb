require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Load .env file in development and test environments
if Rails.env.development? || Rails.env.test?
  Dotenv::Railtie.load
end

module SnacksApi
  class Application < Rails::Application
  end
end

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # rack attack middleware
    config.middleware.use Rack::Attack

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Eastern Time (US & Canada)"
    config.active_record.default_timezone = :local
    # config.eager_load_paths << Rails.root.join("extras")

    # create a logger with a file as a logging target
    config.logger = Logger.new("log/important.log")
    # set the minimum log level
    config.log_level = :info
  end
end
