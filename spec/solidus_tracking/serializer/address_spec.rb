# frozen_string_literal: true

RSpec.describe SolidusTracking::Serializer::Address do
  describe '.serialize' do
    it 'serializes the address' do
      address = build(:address)

      expect(described_class.serialize(address)).to be_instance_of(Hash)
    end
  end
end
