# frozen_string_literal: true

RSpec.describe Spree::Order do
  describe '#next!' do
    context 'when the order is in the cart state' do
      it 'tracks the Started Checkout event' do
        order = create(:order_with_line_items)

        order.next!

        expect(SolidusTracking::TrackEventJob).to have_been_enqueued.with(
          'started_checkout',
          order: order,
        ).at_least(:once)
      end
    end
  end

  describe '#complete!' do
    it 'tracks the Placed Order event' do
      order = Spree::TestingSupport::OrderWalkthrough.up_to(:payment)

      order.complete!

      expect(SolidusTracking::TrackEventJob).to have_been_enqueued.with(
        'placed_order',
        order: order,
      ).at_least(:once)
    end

    it 'tracks the Ordered Product events' do
      order = Spree::TestingSupport::OrderWalkthrough.up_to(:payment)

      order.complete!
      order.line_items.each do |line_item|
        expect(SolidusTracking::TrackEventJob).to have_been_enqueued.with(
          'ordered_product',
          line_item: line_item,
        ).at_least(:once)
      end
    end

    unless defined?(Spree::OrderMailerSubscriber)
      context 'when disable_builtin_emails is true' do
        it 'does not send the confirmation email' do
          allow(SolidusTracking.configuration).to receive(:disable_builtin_emails).and_return(true)
          order = Spree::TestingSupport::OrderWalkthrough.up_to(:payment)

          expect(Spree::OrderMailer).not_to receive(:confirm_email)

          order.complete!
        end
      end

      context 'when disable_builtin_emails is false' do
        it 'sends the confirmation email' do
          allow(SolidusTracking.configuration).to receive(:disable_builtin_emails).and_return(false)
          order = Spree::TestingSupport::OrderWalkthrough.up_to(:payment)

          expect(Spree::OrderMailer).to receive(:confirm_email).and_call_original

          order.complete!
        end
      end
    end
  end

  describe '#canceled_by' do
    it 'tracks the Cancelled Order event' do
      order = create(:completed_order_with_totals)

      order.canceled_by(create(:user))

      expect(SolidusTracking::TrackEventJob).to have_been_enqueued.with(
        'cancelled_order',
        order: order,
      ).at_least(:once)
    end

    context 'when disable_builtin_emails is true' do
      it 'does not send the cancellation email' do
        allow(SolidusTracking.configuration).to receive(:disable_builtin_emails).and_return(true)
        order = create(:completed_order_with_totals)

        expect(Spree::OrderMailer).not_to receive(:cancel_email)

        order.canceled_by(create(:user))
      end
    end

    context 'when disable_builtin_emails is false' do
      it 'sends the cancellation email' do
        allow(SolidusTracking.configuration).to receive(:disable_builtin_emails).and_return(false)
        order = create(:completed_order_with_totals)

        expect(Spree::OrderMailer).to receive(:cancel_email).and_call_original

        order.canceled_by(create(:user))
      end
    end
  end

  describe 'shipping an order' do
    it 'tracks the Fulfilled Order event' do
      order = create(:order_ready_to_ship)
      order.shipments.each(&:ship!)

      expect(SolidusTracking::TrackEventJob).to have_been_enqueued.with(
        'fulfilled_order',
        order: order,
      )
    end
  end
end
