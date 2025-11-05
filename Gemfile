# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

solidus_version = ENV.fetch("SOLIDUS_BRANCH", "v4.5")
gem "solidus", github: "solidusio/solidus", branch: solidus_version

# Needed to help Bundler figure out how to resolve dependencies,
# otherwise it takes forever to resolve them.
# See https://github.com/bundler/bundler/issues/6677
rails_requirement_string = ENV.fetch("RAILS_VERSION", ">0.a")
gem "rails", rails_requirement_string

# Provides basic authentication functionality for testing parts of your engine
gem "solidus_auth_devise"

# Standard library gems that became separate in Ruby 3.4+
gem "bigdecimal"
gem "mutex_m"
gem "drb"
gem "csv"
gem "ostruct"

# This is locked due to a "stack level too deep" error/bug in v0.10.0
gem "state_machines", "~> 0.6.0"

gem "concurrent-ruby", "1.3.4"

case ENV["DB"]
when "mysql"
  gem "mysql2"
when "postgresql"
  gem "pg"
else
  rails_version = Gem::Requirement.new(rails_requirement_string).requirements[0][1]
  sqlite_version = (rails_version < Gem::Version.new(7.2)) ? "~> 1.4" : "~> 2.0"

  gem "sqlite3", sqlite_version
end

gemspec

# Use a local Gemfile to include development dependencies that might not be
# relevant for the project or for other contributors, e.g. pry-byebug.
#
# We use `send` instead of calling `eval_gemfile` to work around an issue with
# how Dependabot parses projects: https://github.com/dependabot/dependabot-core/issues/1658.
send(:eval_gemfile, "Gemfile-local") if File.exist? "Gemfile-local"
