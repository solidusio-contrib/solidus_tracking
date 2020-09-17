# frozen_string_literal: true

module SolidusTracking
  module Spree
    module User
      module TrackSignup
        def self.prepended(base)
          base.after_commit :track_signup, on: :create
        end

        private

        def track_signup
          SolidusTracking.track_later 'created_account', user: self
        end
      end
    end
  end
end

Spree.user_class.prepend(SolidusTracking::Spree::User::TrackSignup)
