# frozen_string_literal: true

SolidusTracking.configure do |config|
  # Configure all the trackers you want to integrate with here.
  # config.trackers << SolidusKlaviyo::Tracker.new(
  #   api_key: 'YOUR_KLAVIYO_API_KEY',
  # )

  # A proc that accepts a variant and returns the URL of that variant's PDP.
  config.variant_url_builder = proc do |variant|
    Spree::Core::Engine.routes.url_helpers.edit_password_url(
      variant.product,
      protocol: 'https',
      host: Spree::Store.default.url,
    )
  end

  # A proc that accepts a variant and returns the URL of that variant's main image.
  config.image_url_builder = proc do |variant|
    image = variant.gallery.images.first
    image&.attachment&.url(:product)
  end

  # A proc that accepts a user and password reset token and returns the URL for completing
  # the password reset procedure.
  config.password_reset_url_builder = proc do |_user, token|
    Spree::Core::Engine.routes.url_helpers.edit_password_url(
      protocol: 'https',
      host: Spree::Store.default.url,
      reset_password_token: token,
    )
  end

  # A proc that accepts an order and returns the URL for tracking the order's status.
  config.order_url_builder = proc do |order|
    Spree::Core::Engine.routes.url_helpers.order_url(
      order,
      protocol: 'https',
      host: Spree::Store.default.url,
    )
  end

  # Disable the built-in emails for the integrated events?
  # This is useful if you'll send the transactional emails via a tracker instead.
  config.disable_builtin_emails = false

  # You can register custom events or override the defaults by manipulating the `events` hash.
  # config.events['my_custom_event'] = MyApp::Events::MyCustomEvent
  # config.events['placed_order'] = MyApp::Events::PlacedOrder

  # In test mode, all calls to `#track_now` and `#subscribe_now` are recorded and their
  # responses are mocked.
  config.test_mode = Rails.env.test?
end
