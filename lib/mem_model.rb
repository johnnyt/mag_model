lib_dir = File.dirname(__FILE__)
$LOAD_PATH << lib_dir unless $LOAD_PATH.include? lib_dir

require 'active_attr'
require 'securerandom'
require 'set'
require 'active_support/dependencies/autoload'

module MemModel
  def maglev?
    !defined?(Maglev).nil?
  end
  module_function :maglev?

  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Guid
  autoload :RootedBase
  autoload :RootedStore
end

require 'mem_model/version'
