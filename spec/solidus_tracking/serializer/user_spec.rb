# frozen_string_literal: true

RSpec.describe SolidusTracking::Serializer::User do
  describe '.serialize' do
    it 'serializes the user' do
      user = build_stubbed(:user)

      expect(described_class.serialize(user)).to be_instance_of(Hash)
    end
  end
end
