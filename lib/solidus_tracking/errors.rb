# frozen_string_literal: true

module SolidusTracking
  class UnregisteredEventError < ArgumentError
    def initialize(event_name, *args)
      super("#{event_name} is not a registered event", *args)
    end
  end
end
