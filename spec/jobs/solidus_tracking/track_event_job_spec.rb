# frozen_string_literal: true

RSpec.describe SolidusTracking::TrackEventJob do
  it 'tracks the event' do
    solidus_tracking = class_spy(SolidusTracking)
    stub_const('SolidusTracking', solidus_tracking)

    described_class.perform_now('custom_event', payload_key: 'value')

    expect(solidus_tracking).to have_received(:track_now).with('custom_event', payload_key: 'value')
  end
end
