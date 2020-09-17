# frozen_string_literal: true

module SolidusTracking
  module Serializer
    class CustomerProperties < Base
      def user_or_email
        object
      end

      def as_json(_options = {})
        if user_or_email.respond_to?(:email)
          Serializer::User.serialize(user_or_email).merge('$email' => user_or_email.email)
        else
          { '$email' => user_or_email }
        end
      end
    end
  end
end
