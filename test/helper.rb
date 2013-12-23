require 'rubygems'

# Disable warning message
require 'i18n'
I18n.enforce_available_locales = false

require 'coveralls'
Coveralls.wear!

require File.expand_path('lib/mem_model')
require 'active_model/lint'
gem 'minitest', '5.2.0'
require 'minitest/autorun'
