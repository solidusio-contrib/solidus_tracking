# frozen_string_literal: true

RSpec.describe SolidusTracking::Event::OrderedProduct do
  describe '#name' do
    it 'returns the name of the event' do
      line_item = build_stubbed(:line_item)

      event = described_class.new(line_item: line_item)

      expect(event.name).to eq('Ordered Product')
    end
  end

  describe '#email' do
    it 'returns the email on the order' do
      line_item = build_stubbed(:line_item)

      event = described_class.new(line_item: line_item)

      expect(event.email).to eq(line_item.order.email)
    end
  end

  describe '#customer_properties' do
    it 'returns the serialized customer information' do
      line_item = build_stubbed(:line_item)
      allow(SolidusTracking::Serializer::CustomerProperties).to receive(:serialize)
        .with(line_item.order.user)
        .and_return('$email' => 'jdoe@example.com')

      event = described_class.new(line_item: line_item)

      expect(event.customer_properties).to eq(
        '$email' => 'jdoe@example.com',
      )
    end
  end

  describe '#properties' do
    it 'includes the serialized line item information' do
      line_item = build_stubbed(:line_item)
      allow(SolidusTracking::Serializer::LineItem).to receive(:serialize)
        .with(line_item)
        .and_return('foo' => 'bar')

      event = described_class.new(line_item: line_item)

      expect(event.properties).to include('foo' => 'bar')
    end

    it 'includes an event ID and value' do
      line_item = build_stubbed(:line_item)
      allow(SolidusTracking::Serializer::LineItem).to receive(:serialize)
        .with(line_item)
        .and_return('foo' => 'bar')

      event = described_class.new(line_item: line_item)

      expect(event.properties).to include(
        '$event_id' => line_item.id.to_s,
        '$value' => line_item.amount,
      )
    end
  end

  describe '#time' do
    it "returns the line item's creation time" do
      line_item = build_stubbed(:line_item)

      event = described_class.new(line_item: line_item)

      expect(event.time).to eq(line_item.created_at)
    end
  end
end
