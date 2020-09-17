# frozen_string_literal: true

RSpec.describe SolidusTracking::Serializer::Payment do
  describe '.serialize' do
    it 'serializes the payment' do
      payment = build_stubbed(:payment)

      expect(described_class.serialize(payment)).to be_instance_of(Hash)
    end
  end
end
