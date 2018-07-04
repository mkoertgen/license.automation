ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# bootsnap broken on jruby, cf.: https://github.com/rails/rails/issues/32641
unless defined? JRUBY_VERSION
  require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
end
