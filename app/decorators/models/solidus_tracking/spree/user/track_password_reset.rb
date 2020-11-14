# frozen_string_literal: true

module SolidusTracking
  module Spree
    module User
      module TrackPasswordReset
        def send_reset_password_instructions
          token = super
          SolidusTracking.automatic_track_later('reset_password', user: self, token: token)
          token
        end
      end
    end
  end
end

Spree.user_class.prepend(SolidusTracking::Spree::User::TrackPasswordReset)
