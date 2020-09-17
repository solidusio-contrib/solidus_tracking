# frozen_string_literal: true

module SolidusTracking
  module Event
    class CreatedAccount < Base
      def name
        'Created Account'
      end

      delegate :email, to: :user

      def customer_properties
        Serializer::CustomerProperties.serialize(user)
      end

      def properties
        Serializer::User.serialize(user).merge(
          '$event_id' => user.id.to_s,
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
