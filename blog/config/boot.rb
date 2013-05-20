require 'rubygems'
require 'yaml'
# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

APP_CONFIG = YAML.load_file(File.expand_path('..', __FILE__) + '/app_config.yml')
puts APP_CONFIG