# frozen_string_literal: true

module SolidusTracking
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def copy_initializer
        template 'initializer.rb', 'config/initializers/solidus_tracking.rb'
      end
    end
  end
end
