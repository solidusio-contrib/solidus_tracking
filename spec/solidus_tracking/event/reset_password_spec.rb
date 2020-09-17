# frozen_string_literal: true

RSpec.describe SolidusTracking::Event::ResetPassword do
  describe '#name' do
    it 'returns the name of the event' do
      user = build_stubbed(:user)

      event = described_class.new(user: user, token: 'reset_token')

      expect(event.name).to eq('Reset Password')
    end
  end

  describe '#email' do
    it 'returns the email on the user' do
      user = build_stubbed(:user)

      event = described_class.new(user: user, token: 'reset_token')

      expect(event.email).to eq(user.email)
    end
  end

  describe '#customer_properties' do
    it 'returns the serialized customer information' do
      user = build_stubbed(:user)
      allow(SolidusTracking::Serializer::CustomerProperties).to receive(:serialize)
        .with(user)
        .and_return('$email' => 'jdoe@example.com')

      event = described_class.new(user: user, token: 'reset_token')

      expect(event.customer_properties).to eq(
        '$email' => 'jdoe@example.com',
      )
    end
  end

  describe '#properties' do
    it 'includes the serialized customer information' do
      user = build_stubbed(:user)
      allow(SolidusTracking::Serializer::User).to receive(:serialize)
        .with(user)
        .and_return('Full Name' => 'John Doe')

      event = described_class.new(user: user, token: 'reset_token')

      expect(event.properties).to include('Full Name' => 'John Doe')
    end

    it 'includes an event ID' do
      user = build_stubbed(:user)
      allow(SolidusTracking::Serializer::User).to receive(:serialize)
        .with(user)
        .and_return('Full Name' => 'John Doe')

      event = described_class.new(user: user, token: 'reset_token')

      expect(event.properties).to include(
        '$event_id' => an_instance_of(String),
      )
    end

    it 'includes the password reset token' do
      user = build_stubbed(:user)
      allow(SolidusTracking::Serializer::User).to receive(:serialize)
        .with(user)
        .and_return('Full Name' => 'John Doe')

      event = described_class.new(user: user, token: 'reset_token')

      expect(event.properties).to include(
        '$event_id' => an_instance_of(String),
        'PasswordResetToken' => 'reset_token',
      )
    end

    it 'includes the password reset URL' do
      user = build_stubbed(:user)
      allow(SolidusTracking::Serializer::User).to receive(:serialize)
        .with(user)
        .and_return('Full Name' => 'John Doe')
      allow(SolidusTracking.configuration).to receive(:password_reset_url_builder)
        .and_return(->(_user, token) { "https://example.com?token=#{token}" })

      event = described_class.new(user: user, token: 'reset_token')

      expect(event.properties).to include(
        '$event_id' => an_instance_of(String),
        'PasswordResetURL' => 'https://example.com?token=reset_token',
      )
    end
  end

  describe '#time' do
    it "returns the time the reset email was sent" do
      user = build_stubbed(:user, reset_password_sent_at: Time.zone.now)

      event = described_class.new(user: user, token: 'reset_token')

      expect(event.time).to eq(user.reset_password_sent_at)
    end
  end
end
