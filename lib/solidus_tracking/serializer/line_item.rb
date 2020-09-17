# frozen_string_literal: true

module SolidusTracking
  module Serializer
    class LineItem < Base
      def line_item
        object
      end

      def as_json(_options = {})
        {
          'ProductID' => line_item.variant_id,
          'SKU' => line_item.variant.sku,
          'ProductName' => line_item.variant.descriptive_name,
          'Quantity' => line_item.quantity,
          'ItemPrice' => line_item.price,
          'RowTotal' => line_item.amount,
          'ProductURL' => SolidusTracking.configuration.variant_url_builder.call(line_item.variant),
          'ImageURL' => SolidusTracking.configuration.image_url_builder.call(line_item.variant),
          'ProductCategories' => line_item.product.taxons.flat_map(&:self_and_ancestors).map(&:name),

        }
      end
    end
  end
end
