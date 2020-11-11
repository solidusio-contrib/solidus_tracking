# frozen_string_literal: true

module SolidusTracking
  module Event
    class Base
      attr_reader :payload

      class << self
        attr_writer :customer_properties_serializer, :payload_serializer

        def customer_properties_serializer
          if !@customer_properties_serializer && superclass < SolidusTracking::Event::Base
            @customer_properties_serializer = superclass.customer_properties_serializer.name
          end

          @customer_properties_serializer ||= '::SolidusTracking::Serializer::CustomerProperties'
          @customer_properties_serializer.constantize
        end

        def payload_serializer
          if !@payload_serializer && superclass < SolidusTracking::Event::Base
            @payload_serializer = superclass.payload_serializer.name
          end

          @payload_serializer.constantize
        end
      end

      def initialize(payload = {})
        @payload = payload
      end
    end
  end
end
