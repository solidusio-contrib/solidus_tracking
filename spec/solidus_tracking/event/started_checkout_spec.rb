# frozen_string_literal: true

RSpec.describe SolidusTracking::Event::StartedCheckout do
  describe '#name' do
    it 'returns the name of the event' do
      order = build_stubbed(:order)

      event = described_class.new(order: order)

      expect(event.name).to eq('Started Checkout')
    end
  end

  describe '#email' do
    it 'returns the email on the order' do
      order = build_stubbed(:order)

      event = described_class.new(order: order)

      expect(event.email).to eq(order.email)
    end
  end

  describe '#customer_properties' do
    it 'returns the serialized customer information' do
      order = build_stubbed(:order)
      allow(SolidusTracking::Serializer::CustomerProperties).to receive(:serialize)
        .with(order.user)
        .and_return('$email' => 'jdoe@example.com')

      event = described_class.new(order: order)

      expect(event.customer_properties).to eq(
        '$email' => 'jdoe@example.com',
      )
    end
  end

  describe '#properties' do
    it 'includes the serialized order information' do
      order = build_stubbed(:order)
      allow(SolidusTracking::Serializer::Order).to receive(:serialize)
        .with(order)
        .and_return('foo' => 'bar')

      event = described_class.new(order: order)

      expect(event.properties).to include('foo' => 'bar')
    end

    it 'includes an event ID and value' do
      order = build(:order)
      allow(SolidusTracking::Serializer::LineItem).to receive(:serialize)
        .with(order)
        .and_return('foo' => 'bar')

      event = described_class.new(order: order)

      expect(event.properties).to include(
        '$event_id' => order.number,
        '$value' => order.total,
      )
    end
  end

  describe '#time' do
    it "returns the order's completion time" do
      order = build_stubbed(:order)

      event = described_class.new(order: order)

      expect(event.time).to eq(order.updated_at)
    end
  end
end
