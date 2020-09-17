# frozen_string_literal: true

RSpec.describe SolidusTracking::Configuration do
  it 'can be instantiated' do
    expect { described_class.new }.not_to raise_error
  end

  it 'allows registering custom events' do
    configuration = described_class.new

    configuration.events['custom_event'] = OpenStruct

    expect(configuration.events['custom_event']).to eq(OpenStruct)
  end

  describe '#event_klass' do
    context 'when the event is registered' do
      it 'returns the class for the event' do
        configuration = described_class.new

        configuration.events['custom_event'] = OpenStruct

        expect(configuration.event_klass(:custom_event)).to eq(OpenStruct)
      end
    end

    context 'when the event is not registered' do
      it 'returns nil' do
        configuration = described_class.new

        expect(configuration.event_klass(:custom_event)).to be_nil
      end
    end
  end

  describe '#event_klass!' do
    context 'when the event is registered' do
      it 'returns the class for the event' do
        configuration = described_class.new

        configuration.events['custom_event'] = OpenStruct

        expect(configuration.event_klass!(:custom_event)).to eq(OpenStruct)
      end
    end

    context 'when the event is not registered' do
      it 'raises an UnregisteredEventError' do
        configuration = described_class.new

        expect {
          configuration.event_klass!(:custom_event)
        }.to raise_error(SolidusTracking::UnregisteredEventError)
      end
    end
  end
end
