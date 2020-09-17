# frozen_string_literal: true

module SolidusTracking
  module Serializer
    class User < Base
      def user
        object
      end

      def as_json(_options = {})
        {
          'Email' => user.email,
        }
      end
    end
  end
end
