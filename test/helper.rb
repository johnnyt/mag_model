require 'rubygems'

require 'coveralls'
Coveralls.wear!

require File.expand_path('lib/mem_model')
require 'active_model/lint'
gem 'minitest', '5.2.0'
require 'minitest/autorun'
