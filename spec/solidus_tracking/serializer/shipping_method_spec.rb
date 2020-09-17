# frozen_string_literal: true

RSpec.describe SolidusTracking::Serializer::ShippingMethod do
  describe '.serialize' do
    it 'serializes the shipping method' do
      shipping_method = build_stubbed(:shipping_method)

      expect(described_class.serialize(shipping_method)).to be_instance_of(Hash)
    end
  end
end
