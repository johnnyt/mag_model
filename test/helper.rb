require 'rubygems'

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
Dir[File.expand_path('../support/*.rb', __FILE__)].each { |file| require file }
require 'minitest'
require 'minitest/autorun'
