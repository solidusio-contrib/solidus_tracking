# frozen_string_literal: true

RSpec.describe SolidusTracking::Serializer::PaymentSource do
  describe '.serialize' do
    it 'serializes the payment source' do
      payment_source = build(:credit_card)

      expect(described_class.serialize(payment_source)).to be_instance_of(Hash)
    end
  end

  describe 'the serialized output' do
    it 'can be converted to JSON when the payment source is persisted to the database' do
      credit_card = create(:credit_card)

      expect { described_class.serialize(credit_card).to_json }.not_to raise_error
    end
  end
end
