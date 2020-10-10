# frozen_string_literal: true

module SolidusTracking
  module Spree
    module Shipment
      module DisableShipmentEmail
        def after_ship
          self.suppress_mailer ||= SolidusTracking.configuration.disable_builtin_emails
          super
        end
      end
    end
  end
end

Spree::Shipment.prepend(SolidusTracking::Spree::Shipment::DisableShipmentEmail)
