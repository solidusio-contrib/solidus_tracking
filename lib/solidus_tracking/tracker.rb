# frozen_string_literal: true

module SolidusTracking
  class Tracker
    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def track(_event)
      raise NotImplementedError
    end
  end
end
