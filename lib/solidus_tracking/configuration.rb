# frozen_string_literal: true

module SolidusTracking
  class Configuration
    BUILT_IN_EVENTS = {
      'ordered_product' => 'SolidusTracking::Event::OrderedProduct',
      'placed_order' => 'SolidusTracking::Event::PlacedOrder',
      'started_checkout' => 'SolidusTracking::Event::StartedCheckout',
      'cancelled_order' => 'SolidusTracking::Event::CancelledOrder',
      'reset_password' => 'SolidusTracking::Event::ResetPassword',
      'created_account' => 'SolidusTracking::Event::CreatedAccount',
      'fulfilled_order' => 'SolidusTracking::Event::FulfilledOrder',
    }.freeze

    attr_accessor(
      :variant_url_builder, :image_url_builder, :password_reset_url_builder, :order_url_builder,
      :disable_builtin_emails, :test_mode,
    )

    def initialize
      @disable_builtin_emails = false
    end

    def trackers
      @trackers ||= []
    end

    def events
      @events ||= BUILT_IN_EVENTS.dup
    end

    def automatic_events
      @automatic_events ||= BUILT_IN_EVENTS.keys
    end

    def event_klass(name)
      klass = events[name.to_s]
      klass.is_a?(String) ? klass.constantize : klass
    end

    def event_klass!(name)
      event_klass(name) || raise(UnregisteredEventError, name)
    end
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    alias config configuration

    def configure
      yield configuration
    end
  end
end
