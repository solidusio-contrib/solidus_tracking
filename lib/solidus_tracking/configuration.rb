# frozen_string_literal: true

module SolidusTracking
  class Configuration
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
      @events ||= {
        'ordered_product' => SolidusTracking::Event::OrderedProduct,
        'placed_order' => SolidusTracking::Event::PlacedOrder,
        'started_checkout' => SolidusTracking::Event::StartedCheckout,
        'cancelled_order' => SolidusTracking::Event::CancelledOrder,
        'reset_password' => SolidusTracking::Event::ResetPassword,
        'created_account' => SolidusTracking::Event::CreatedAccount,
        'fulfilled_order' => SolidusTracking::Event::FulfilledOrder,
      }
    end

    def event_klass(name)
      events[name.to_s]
    end

    def event_klass!(name)
      event_klass(name) || raise(UnregisteredEventError, name)
    end
  end
end
