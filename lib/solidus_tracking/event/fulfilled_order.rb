# frozen_string_literal: true

module SolidusTracking
  module Event
    class FulfilledOrder < Base
      def name
        'Fulfilled Order'
      end

      delegate :email, to: :order

      def customer_properties
        Serializer::CustomerProperties.serialize(order.user || order.email)
      end

      def properties
        Serializer::Order.serialize(order).merge(
          '$event_id' => order.id.to_s,
          '$value' => order.total,
        )
      end

      def time
        order.shipments.maximum(:shipped_at)
      end

      private

      def order
        payload.fetch(:order)
      end
    end
  end
end
