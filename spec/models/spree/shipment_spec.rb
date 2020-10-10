# frozen_string_literal: true

RSpec.describe Spree::Shipment do
  describe '#ship!' do
    context 'when disable_builtin_emails is true' do
      it 'does not send the shipment email' do
        allow(SolidusTracking.configuration).to receive(:disable_builtin_emails).and_return(true)
        stub_const('Spree::CartonMailer', class_spy(Spree::CartonMailer))

        shipment = create(:order_ready_to_ship).shipments.first
        shipment.ship!

        expect(Spree::CartonMailer).not_to have_received(:shipped_email)
      end
    end

    context 'when disable_builtin_emails is false' do
      context 'when suppress_mailer is already true' do
        it 'does not send the shipment email' do
          allow(SolidusTracking.configuration).to receive(:disable_builtin_emails).and_return(false)
          stub_const('Spree::CartonMailer', class_spy(Spree::CartonMailer))

          shipment = create(:order_ready_to_ship).shipments.first
          shipment.suppress_mailer = true
          shipment.ship!

          expect(Spree::CartonMailer).not_to have_received(:shipped_email)
        end
      end

      context 'when suppress_mailer is false' do
        it 'sends the shipment email' do
          allow(SolidusTracking.configuration).to receive(:disable_builtin_emails).and_return(false)
          stub_const('Spree::CartonMailer', class_spy(
            Spree::CartonMailer,
            shipped_email: instance_spy('ActionMailer::Delivery'),
          ))

          shipment = create(:order_ready_to_ship).shipments.first
          shipment.ship!

          expect(Spree::CartonMailer).to have_received(:shipped_email)
        end
      end
    end
  end
end
