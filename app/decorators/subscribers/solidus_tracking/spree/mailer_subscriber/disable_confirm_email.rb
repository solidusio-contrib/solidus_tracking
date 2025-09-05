# frozen_string_literal: true

module SolidusTracking
  module Spree
    module MailerSubscriber
      module DisableConfirmEmail
        def self.prepended(base)
          base.module_eval do
            alias_method :original_send_confirmation_email, :send_confirmation_email

            def send_confirmation_email(event)
              return if SolidusTracking.configuration.disable_builtin_emails

              original_send_confirmation_email(event)
            end
          end
        end
      end
    end
  end
end

Spree::OrderMailerSubscriber.prepend(SolidusTracking::Spree::MailerSubscriber::DisableConfirmEmail)
