# frozen_string_literal: true

module SolidusTracking
  module Serializer
    class PaymentSource < Base
      def source
        object
      end

      def as_json(_options = {})
        return unless source.is_a?(::Spree::CreditCard)

        {
          'Type' => source.class.to_s,
          'CcType' => source.cc_type,
          'Month' => source.month,
          'Year' => source.year,
          'LastDigits' => source.last_digits,
          'Name' => source.name,
          'Address' => Address.serialize(source.address),
        }
      end
    end
  end
end
