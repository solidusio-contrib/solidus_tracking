module SolidusTracking
  module Spree
    module Order
      module DisableCancelEmail
        def send_cancel_email
          super unless SolidusTracking.configuration.disable_builtin_emails
        end
      end
    end
  end
end

Spree::Order.prepend(SolidusTracking::Spree::Order::DisableCancelEmail)
