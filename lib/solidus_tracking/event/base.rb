# frozen_string_literal: true

module SolidusTracking
  module Event
    class Base
      attr_reader :payload

      class << self
        attr_writer :customer_properties_serializer, :payload_serializer

        def customer_properties_serializer
          @customer_properties_serializer ||= '::SolidusTracking::Serializer::CustomerProperties'
          @customer_properties_serializer.constantize
        end

        def payload_serializer
          @payload_serializer.constantize
        end
      end

      def initialize(payload = {})
        @payload = payload
      end
    end
  end
end
