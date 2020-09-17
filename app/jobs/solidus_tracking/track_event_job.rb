# frozen_string_literal: true

module SolidusTracking
  class TrackEventJob < ApplicationJob
    queue_as :default

    def perform(event_name, event_payload = {})
      SolidusTracking.track_now(event_name, event_payload)
    end
  end
end
