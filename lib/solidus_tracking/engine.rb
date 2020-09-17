# frozen_string_literal: true

require 'spree/core'
require 'solidus_tracking'

module SolidusTracking
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_tracking'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
