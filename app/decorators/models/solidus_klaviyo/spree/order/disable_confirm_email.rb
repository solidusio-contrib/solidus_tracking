# frozen_string_literal: true

module SolidusTracking
  module Spree
    module Order
      module DisableConfirmEmail
        def deliver_order_confirmation_email
          super unless SolidusTracking.configuration.disable_builtin_emails
        end
      end
    end
  end
end

if Spree.solidus_gem_version < Gem::Version.new('2.9.0')
  Spree::Order.prepend(SolidusTracking::Spree::Order::DisableConfirmEmail)
end
