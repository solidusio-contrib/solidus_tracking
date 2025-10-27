# frozen_string_literal: true

module SolidusTracking
  module Spree
    module User
      module TrackSignup
        extend ActiveSupport::Concern

        prepended do
          after_commit :track_signup, on: :create
        end

        private

        def track_signup
          SolidusTracking.automatic_track_later 'created_account', user: self
        end
      end
    end
  end
end

Spree.user_class.prepend(SolidusTracking::Spree::User::TrackSignup)
