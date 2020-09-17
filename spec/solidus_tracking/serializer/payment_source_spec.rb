# frozen_string_literal: true

RSpec.describe SolidusTracking::Serializer::PaymentSource do
  describe '.serialize' do
    it 'serializes the payment source' do
      payment_source = build_stubbed(:credit_card)

      expect(described_class.serialize(payment_source)).to be_instance_of(Hash)
    end
  end
end
