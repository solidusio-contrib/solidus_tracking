# frozen_string_literal: true

require_relative 'lib/solidus_tracking/version'

Gem::Specification.new do |spec|
  spec.name = 'solidus_tracking'
  spec.version = SolidusTracking::VERSION
  spec.authors = ['Alessandro Desantis']
  spec.email = 'desa.alessandro@gmail.com'

  spec.summary = 'Data tracking architecture for Solidus stores.'
  spec.homepage = 'https://github.com/aldesantis/solidus_tracking'
  spec.license = 'BSD-3-Clause'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/solidusio-contrib/solidus_tracking'
  spec.metadata['changelog_uri'] = 'https://github.com/aldesantis/solidus_tracking/releases'

  spec.required_ruby_version = Gem::Requirement.new('>= 3.1')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  files = Dir.chdir(__dir__) { `git ls-files -z`.split("\x0") }

  spec.files = files.grep_v(%r{^(test|spec|features)/})
  spec.test_files = files.grep(%r{^(test|spec|features)/})
  spec.bindir = "exe"
  spec.executables = files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'solidus_core', ['>= 4.0.0', '< 4.6']
  spec.add_dependency 'solidus_support', '~> 0.8'

  spec.add_development_dependency 'solidus_dev_support'
end
