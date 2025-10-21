# frozen_string_literal: true

module SolidusTracking
  module Spree
    module Order
      module TrackOrderLifecycle
        extend ActiveSupport::Concern

        prepended do
          state_machine.after_transition to: :address, do: :track_started_checkout
          state_machine.after_transition to: :complete, do: :track_ordered_product
          state_machine.after_transition to: :complete, do: :track_placed_order
          state_machine.after_transition to: :canceled, do: :track_cancelled_order
        end

        private

        def track_started_checkout
          SolidusTracking.automatic_track_later('started_checkout', order: self)
        end

        def track_ordered_product
          line_items.each do |line_item|
            SolidusTracking.automatic_track_later('ordered_product', line_item: line_item)
          end
        end

        def track_placed_order
          SolidusTracking.automatic_track_later('placed_order', order: self)
        end

        def track_cancelled_order
          SolidusTracking.automatic_track_later('cancelled_order', order: self)
        end
      end
    end
  end
end

Spree::Order.prepend(SolidusTracking::Spree::Order::TrackOrderLifecycle)
