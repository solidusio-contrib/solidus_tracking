# frozen_string_literal: true

RSpec.describe SolidusTracking::Serializer::CustomerProperties do
  describe '.serialize' do
    context 'when passed an object that responds to #email' do
      it 'serializes the object as a user' do
        user = build_stubbed(:user)
        allow(SolidusTracking::Serializer::User).to receive(:serialize)
          .with(user)
          .and_return('Full Name' => 'John Doe')

        expect(described_class.serialize(user)).to include('Full Name' => 'John Doe')
      end

      it 'includes the $email property' do
        user = build_stubbed(:user)
        allow(SolidusTracking::Serializer::User).to receive(:serialize)
          .with(user)
          .and_return('$email' => 'overridden_email')

        expect(described_class.serialize(user)).to include('$email' => user.email)
      end
    end

    context 'when passed a string' do
      it 'uses the string as the $email property' do
        email = 'jdoe@example.com'

        expect(described_class.serialize(email)).to include('$email' => email)
      end
    end
  end
end
