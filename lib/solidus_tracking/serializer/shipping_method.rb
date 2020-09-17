# frozen_string_literal: true

module SolidusTracking
  module Serializer
    class ShippingMethod < Base
      def shipping_method
        object
      end

      def as_json(_options = {})
        {
          'Name' => shipping_method.name,
          'Carrier' => shipping_method.carrier,
          'ServiceLevel' => shipping_method.service_level,
        }
      end
    end
  end
end
