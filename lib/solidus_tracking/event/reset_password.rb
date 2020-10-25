# frozen_string_literal: true

module SolidusTracking
  module Event
    class ResetPassword < Base
      self.payload_serializer = '::SolidusTracking::Serializer::User'

      def name
        'Reset Password'
      end

      delegate :email, to: :user

      def customer_properties
        self.class.customer_properties_serializer.serialize(user)
      end

      def properties
        self.class.payload_serializer.serialize(user).merge(
          '$event_id' => "#{user.id}-#{user.reset_password_sent_at.to_i}",
          'PasswordResetToken' => token,
          'PasswordResetURL' => password_reset_url,
        )
      end

      def time
        user.reset_password_sent_at
      end

      private

      def user
        payload.fetch(:user)
      end

      def token
        payload.fetch(:token)
      end

      def password_reset_url
        SolidusTracking.configuration.password_reset_url_builder.call(user, token)
      end
    end
  end
end
