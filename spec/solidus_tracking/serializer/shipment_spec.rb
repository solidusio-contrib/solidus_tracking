# frozen_string_literal: true

RSpec.describe SolidusTracking::Serializer::Shipment do
  describe '.serialize' do
    it 'serializes the shipment' do
      shipment = build_stubbed(:shipment)

      expect(described_class.serialize(shipment)).to be_instance_of(Hash)
    end
  end
end
