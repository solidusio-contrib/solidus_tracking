# frozen_string_literal: true

RSpec.describe SolidusTracking::Serializer::Order do
  describe '.serialize' do
    it 'serializes the order' do
      order = create(:completed_order_with_promotion)

      expect(described_class.serialize(order)).to be_instance_of(Hash)
    end

    it 'uses default promotion code to promotions that apply to all orders' do
      promotion = create(:promotion_with_order_adjustment, apply_automatically: true)
      order = create(:order)

      promotion.activate(order: order)

      expect(described_class.serialize(order)).to include({ "DiscountCode" => "all orders" })
    end

    it 'does not include ineligible discount codes' do
      promotions = Array.new(2) { create(:promotion_with_order_adjustment, apply_automatically: true) }
      order = create(:order)

      promotions.each { |promo| promo.activate(order: order) }
      order.updater.update

      expect(described_class.serialize(order)["DiscountCode"]).not_to include("all orders, all orders")
    end
  end
end
