# frozen_string_literal: true

module SolidusTracking
  module TestingSupport
    class TestRegistry
      def tracked_events
        @tracked_events ||= []
      end
    end
  end
end
