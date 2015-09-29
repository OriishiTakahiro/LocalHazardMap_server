require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module LocalHazardMap
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
		config.web_console.whitelist_ips="0.0.0.0"
		config.web_console.whitelist_ips="192.168.2.2"
		config.web_console.whitelist_ips="192.168.0.1"
		config.web_console.whitelist_ips="192.168.0.2"
		config.web_console.whitelist_ips="192.168.0.3"
		config.web_console.whitelist_ips="192.168.0.4"
		config.web_console.whitelist_ips="192.168.0.5"
		config.web_console.whitelist_ips="192.168.0.6"
		config.web_console.whitelist_ips="192.168.0.7"
		config.web_console.whitelist_ips="192.168.0.8"
		config.web_console.whitelist_ips="192.168.0.9"
		
  end
end
