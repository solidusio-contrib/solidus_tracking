# frozen_string_literal: true

RSpec.configure do |config|
  config.before do
    SolidusTracking.configure do |c|
      c.test_mode = false
      c.variant_url_builder = proc do |variant|
        "https://example.com/products/#{variant.product.slug}"
      end
      c.image_url_builder = proc do |variant|
        "https://example.com/products/#{variant.product.slug}.jpg"
      end
      c.password_reset_url_builder = proc do |_user, token|
        "https://example.com/reset_password?token=#{token}"
      end
      c.order_url_builder = proc do |order|
        "https://example.com/orders/#{order.number}"
      end
    end
  end
end
