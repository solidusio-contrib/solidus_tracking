# frozen_string_literal: true

RSpec.describe SolidusTracking::Serializer::Order do
  describe '.serialize' do
    it 'serializes the order' do
      order = build_stubbed(:completed_order_with_totals)

      expect(described_class.serialize(order)).to be_instance_of(Hash)
    end
  end
end
