# frozen_string_literal: true

module SolidusTracking
  module Spree
    module Order
      module TrackOrderFulfillment
        def self.prepended(base)
          base.after_update :track_fulfilled_order
        end

        private

        def track_fulfilled_order
          return unless previous_changes.key?('shipment_state') && shipment_state == 'shipped'

          SolidusTracking.automatic_track_later('fulfilled_order', order: self)
        end
      end
    end
  end
end

Spree::Order.prepend(SolidusTracking::Spree::Order::TrackOrderFulfillment)
