# frozen_string_literal: true

module SolidusTracking
  module Serializer
    class Shipment < Base
      def shipment
        object
      end

      def as_json(_options = {})
        {
          'Tracking' => shipment.tracking,
          'TrackingURL' => shipment.tracking_url,
          'Number' => shipment.number,
          'ShippedAt' => shipment.shipped_at,
          'State' => shipment.state,
          'AdjustmentTotal' => shipment.adjustment_total,
          'AdditionalTaxTotal' => shipment.additional_tax_total,
          'PromoTotal' => shipment.promo_total,
          'IncludedTaxTotal' => shipment.included_tax_total,
          'Cost' => shipment.cost,
          'Total' => shipment.total,
          'TotalBeforeTax' => shipment.total_before_tax,
          'TotalExcludingVat' => shipment.total_excluding_vat,
          'TotalWithItems' => shipment.total_with_items,
          'ItemCost' => shipment.item_cost,
          'ShippingMethod' => (ShippingMethod.serialize(shipment.shipping_method) if shipment.shipping_method),

        }
      end
    end
  end
end
