require 'rubygems'

# Disable warning message
require 'i18n'
I18n.enforce_available_locales = false

# Only run coverage in MRI
unless defined? Maglev
  if ENV['CI']
    require 'coveralls'
    Coveralls.wear!
  else
    require 'simplecov'
    SimpleCov.start
  end
end

require File.expand_path('lib/mem_model')
require 'active_model/lint'
gem 'minitest', '5.2.0'
require 'minitest/autorun'
