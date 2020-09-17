# frozen_string_literal: true

RSpec.describe SolidusTracking::Event::CreatedAccount do
  describe '#name' do
    it 'returns the name of the event' do
      user = build_stubbed(:user)

      event = described_class.new(user: user)

      expect(event.name).to eq('Created Account')
    end
  end

  describe '#email' do
    it 'returns the email on the user' do
      user = build_stubbed(:user)

      event = described_class.new(user: user)

      expect(event.email).to eq(user.email)
    end
  end

  describe '#customer_properties' do
    it 'returns the serialized customer information' do
      user = build_stubbed(:user)
      allow(SolidusTracking::Serializer::CustomerProperties).to receive(:serialize)
        .with(user)
        .and_return('$email' => 'jdoe@example.com')

      event = described_class.new(user: user)

      expect(event.customer_properties).to eq(
        '$email' => 'jdoe@example.com',
      )
    end
  end

  describe '#properties' do
    it 'includes the serialized customer information' do
      user = build_stubbed(:user)
      allow(SolidusTracking::Serializer::User).to receive(:serialize)
        .with(user)
        .and_return('Full Name' => 'John Doe')

      event = described_class.new(user: user)

      expect(event.properties).to include('Full Name' => 'John Doe')
    end

    it 'includes an event ID' do
      user = build_stubbed(:user)
      allow(SolidusTracking::Serializer::User).to receive(:serialize)
        .with(user)
        .and_return('Full Name' => 'John Doe')

      event = described_class.new(user: user)

      expect(event.properties).to include(
        '$event_id' => an_instance_of(String),
      )
    end
  end

  describe '#time' do
    it 'returns the time the user was created' do
      user = build_stubbed(:user)

      event = described_class.new(user: user)

      expect(event.time).to eq(user.created_at)
    end
  end
end
