ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

# 添加对mutex_m的支持
require 'mutex_m'

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'rubygems'
require 'bundler'

# Set up load paths for all bundled gems
Bundler.setup

if ENV['RAILS_ENV'] == 'development'
  Bundler.require(:development)
else
  Bundler.require(:default, ENV['RAILS_ENV'])
end
