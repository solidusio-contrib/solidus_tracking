# frozen_string_literal: true

module SolidusTracking
  module Event
    class OrderedProduct < Base
      def name
        'Ordered Product'
      end

      def email
        line_item.order.email
      end

      def customer_properties
        Serializer::CustomerProperties.serialize(line_item.order.user || line_item.order.email)
      end

      def properties
        Serializer::LineItem.serialize(line_item).merge(
          '$event_id' => "#{line_item.order.number}-#{line_item.id}",
          '$value' => line_item.amount,
        )
      end

      def time
        line_item.created_at
      end

      private

      def line_item
        payload.fetch(:line_item)
      end
    end
  end
end
