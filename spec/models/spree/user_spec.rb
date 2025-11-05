# frozen_string_literal: true

RSpec.describe Spree::User do
  describe '#save' do
    it 'tracks the Signed Up event' do
      user = create(:user)

      expect(SolidusTracking::TrackEventJob).to have_been_enqueued.with(
        'created_account',
        user: user,
      )
    end
  end


  describe '#send_reset_password_instructions' do
    before do
      allow(Devise.mailer)
        .to receive(:reset_password_instructions)
        .and_return(double(deliver_now: true))
    end

    it 'tracks the Requested Password Reset event' do
      create(:store)
      user = create(:user)

      user.send_reset_password_instructions

      expect(SolidusTracking::TrackEventJob).to have_been_enqueued.with(
        'reset_password',
        user: user,
        token: an_instance_of(String),
      )
    end

    context 'when disable_builtin_emails is true' do
      it 'does not send the password reset email' do
        allow(SolidusTracking.configuration).to receive(:disable_builtin_emails).and_return(true)
        email = instance_spy('ActionMailer::Delivery')
        allow(Devise.mailer).to receive(:reset_password_instructions).and_return(email)
        create(:store)
        user = create(:user)

        user.send_reset_password_instructions

        expect(email).not_to have_received(:deliver_now)
      end
    end

    context 'when disable_builtin_emails is false' do
      it 'sends the password reset email' do
        allow(SolidusTracking.configuration).to receive(:disable_builtin_emails).and_return(false)
        email = instance_spy('ActionMailer::Delivery')
        allow(Devise.mailer).to receive(:reset_password_instructions).and_return(email)
        create(:store)
        user = create(:user)

        user.send_reset_password_instructions

        expect(email).to have_received(:deliver_now)
      end
    end
  end
end
