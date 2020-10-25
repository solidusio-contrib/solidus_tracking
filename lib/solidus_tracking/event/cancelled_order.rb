# frozen_string_literal: true

module SolidusTracking
  module Event
    class CancelledOrder < Base
      self.payload_serializer = '::SolidusTracking::Serializer::Order'

      def name
        'Cancelled Order'
      end

      delegate :email, to: :order

      def customer_properties
        self.class.customer_properties_serializer.serialize(order.user || order.email)
      end

      def properties
        self.class.payload_serializer.serialize(order).merge(
          '$event_id' => order.number,
          '$value' => order.total,
        )
      end

      def time
        order.canceled_at
      end

      private

      def order
        payload.fetch(:order)
      end
    end
  end
end
