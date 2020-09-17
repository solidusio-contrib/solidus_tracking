# frozen_string_literal: true

RSpec.describe SolidusTracking do
  describe '.configuration' do
    it 'returns an instance of the configuration' do
      expect(described_class.configuration).to be_instance_of(SolidusTracking::Configuration)
    end
  end

  describe '.configure' do
    it 'yields the configuration' do
      expect do |b|
        described_class.configure(&b)
      end.to yield_with_args(an_instance_of(SolidusTracking::Configuration))
    end
  end

  describe '.track_now' do
    context 'when the event is registered' do
      # rubocop:disable RSpec/MultipleExpectations
      it 'tracks the event via the event trackers' do
        event_tracker = instance_spy(SolidusTracking::Tracker)
        allow(described_class.configuration).to receive(:event_klass!)
          .with('custom_event')
          .and_return(OpenStruct)
        allow(described_class.configuration).to receive(:trackers)
          .and_return([event_tracker])

        described_class.track_now('custom_event', payload_key: 'payload_value')

        expect(event_tracker).to have_received(:track) do |event|
          expect(event).to be_an_instance_of(OpenStruct)
          expect(event.payload_key).to eq('payload_value')
        end
      end
      # rubocop:enable RSpec/MultipleExpectations
    end

    context 'when the event is not registered' do
      it 'bubbles up any errors' do
        allow(described_class.configuration).to receive(:event_klass!)
          .with('custom_event')
          .and_raise(SolidusTracking::UnregisteredEventError.new('custom_event'))

        expect {
          described_class.track_now('custom_event', foo: 'bar')
        }.to raise_error(SolidusTracking::UnregisteredEventError, /custom_event/)
      end
    end
  end

  describe '.track_later' do
    context 'when the event is registered' do
      it 'enqueues a TrackEventJob' do
        allow(described_class.configuration).to receive(:event_klass!).with('custom_event')

        described_class.track_later('custom_event', foo: 'bar')

        expect(SolidusTracking::TrackEventJob).to have_been_enqueued.with(
          'custom_event',
          foo: 'bar',
        )
      end
    end

    context 'when the event is not registered' do
      it 'bubbles up any errors' do
        allow(described_class.configuration).to receive(:event_klass!)
          .with('custom_event')
          .and_raise(SolidusTracking::UnregisteredEventError.new('custom_event'))

        expect {
          described_class.track_later('custom_event', foo: 'bar')
        }.to raise_error(SolidusTracking::UnregisteredEventError, /custom_event/)
      end
    end
  end
end
