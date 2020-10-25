# frozen_string_literal: true

module SolidusTracking
  module Event
    class CreatedAccount < Base
      self.payload_serializer = '::SolidusTracking::Serializer::User'

      def name
        'Created Account'
      end

      delegate :email, to: :user

      def customer_properties
        self.class.customer_properties_serializer.serialize(user)
      end

      def properties
        self.class.payload_serializer.serialize(user).merge(
          '$event_id' => "#{user.id}-#{user.created_at.to_i}",
        )
      end

      def time
        user.created_at
      end

      private

      def user
        payload.fetch(:user)
      end
    end
  end
end
