lib_dir = File.dirname(__FILE__)
$LOAD_PATH << lib_dir unless $LOAD_PATH.include? lib_dir

require 'active_attr'
require 'securerandom'
require 'forwardable'
require 'set'

module MemModel
end

require 'mem_model/base'
require 'mem_model/guid'
require 'mem_model/version'
