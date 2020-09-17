# frozen_string_literal: true

module SolidusTracking
  module Serializer
    class Base
      attr_reader :object

      class << self
        def serialize(object)
          new(object).as_json
        end
      end

      def initialize(object)
        @object = object
      end

      def as_json(_options = {})
        raise NotImplementedError
      end
    end
  end
end
