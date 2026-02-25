require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Explicitly require devise to ensure it's loaded early
require 'devise'

module HiphopWebsite
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    config.time_zone = 'Beijing'
    
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.default_locale = :zh
    
    # Ruby 3.4 compatibility fix for static middleware
    config.middleware.delete ActionDispatch::Static
    config.middleware.insert_before 0, ActionDispatch::Static, Rails.root.join('public').to_s
    
    # Skip migration check to avoid issues with Ruby 3.4.5 compatibility
    config.active_record.migration_error = false
  end
end
