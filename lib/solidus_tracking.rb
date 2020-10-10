# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'

require 'solidus_tracking/version'
require 'solidus_tracking/engine'
require 'solidus_tracking/configuration'
require 'solidus_tracking/serializer/base'
require 'solidus_tracking/serializer/address'
require 'solidus_tracking/serializer/order'
require 'solidus_tracking/serializer/line_item'
require 'solidus_tracking/serializer/user'
require 'solidus_tracking/serializer/customer_properties'
require 'solidus_tracking/serializer/shipment'
require 'solidus_tracking/serializer/shipping_method'
require 'solidus_tracking/serializer/payment'
require 'solidus_tracking/serializer/payment_source'
require 'solidus_tracking/event/base'
require 'solidus_tracking/event/ordered_product'
require 'solidus_tracking/event/placed_order'
require 'solidus_tracking/event/started_checkout'
require 'solidus_tracking/event/cancelled_order'
require 'solidus_tracking/event/reset_password'
require 'solidus_tracking/event/created_account'
require 'solidus_tracking/event/fulfilled_order'
require 'solidus_tracking/tracker'
require 'solidus_tracking/errors'
require 'solidus_tracking/testing_support/test_registry'

module SolidusTracking
  class << self
    delegate :tracked_events, to: :test_registry

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end

    def track_now(event_name, event_payload = {})
      event = configuration.event_klass!(event_name).new(event_payload)

      if configuration.test_mode
        SolidusTracking.tracked_events << event
      else
        configuration.trackers.each do |tracker|
          tracker.track(event)
        end
      end
    end

    def track_later(event_name, event_payload = {})
      configuration.event_klass!(event_name) # validate event name
      SolidusTracking::TrackEventJob.perform_later(event_name, event_payload)
    end

    private

    def test_registry
      @test_registry ||= TestingSupport::TestRegistry.new
    end
  end
end
