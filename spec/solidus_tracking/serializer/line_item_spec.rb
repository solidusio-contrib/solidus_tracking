# frozen_string_literal: true

RSpec.describe SolidusTracking::Serializer::LineItem do
  describe '.serialize' do
    it 'serializes the line item' do
      line_item = build_stubbed(:line_item)

      expect(described_class.serialize(line_item)).to be_instance_of(Hash)
    end
  end
end
