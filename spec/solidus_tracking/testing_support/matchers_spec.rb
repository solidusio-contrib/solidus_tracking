# frozen_string_literal: true

require 'solidus_tracking/testing_support/matchers'

RSpec.describe SolidusTracking::TestingSupport::Matchers do
  describe '.have_tracked' do
    it 'matches when the event was tracked' do
      test_registry = SolidusTracking::TestingSupport::TestRegistry.new
      test_registry.tracked_events << SolidusTracking::Event::StartedCheckout.new

      expect(test_registry).to have_tracked(SolidusTracking::Event::StartedCheckout)
    end

    it 'fails when the event was not tracked' do
      test_registry = SolidusTracking::TestingSupport::TestRegistry.new
      test_registry.tracked_events << SolidusTracking::Event::PlacedOrder.new

      expect(test_registry).not_to have_tracked(SolidusTracking::Event::StartedCheckout)
    end

    describe '.with' do
      it 'matches when the event was tracked with the right payload' do
        test_registry = SolidusTracking::TestingSupport::TestRegistry.new
        test_registry.tracked_events << SolidusTracking::Event::StartedCheckout.new(foo: 'bar')

        expect(test_registry).to have_tracked(SolidusTracking::Event::StartedCheckout)
          .with(foo: 'bar')
      end

      it 'fails when the event was tracked with the wrong payload' do
        test_registry = SolidusTracking::TestingSupport::TestRegistry.new
        test_registry.tracked_events << SolidusTracking::Event::StartedCheckout.new(foo: 'baz')

        expect(test_registry).not_to have_tracked(SolidusTracking::Event::StartedCheckout)
          .with(foo: 'bar')
      end
    end
  end
end
