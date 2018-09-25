# frozen_string_literal: true

require File.expand_path("boot", __dir__)

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MovieReview
  class Application < Rails::Application
  config.middleware.use "MyMiddleware"
  # config.middleware.use "AddTextToBody"
  config.middleware.use "AntiDdos"
  end
end
