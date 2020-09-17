# frozen_string_literal: true

require 'rspec/expectations'

module SolidusTracking
  module TestingSupport
    module Matchers
      extend RSpec::Matchers::DSL

      matcher :have_tracked do |klass|
        match do |actual|
          actual.tracked_events.any? do |event|
            event.is_a?(klass) &&
              (!@payload || values_match?(@payload, event.payload))
          end
        end

        chain :with do |payload|
          @payload = payload
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include SolidusTracking::TestingSupport::Matchers
end
