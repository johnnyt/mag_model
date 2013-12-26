lib_dir = File.dirname(__FILE__)
$LOAD_PATH << lib_dir unless $LOAD_PATH.include? lib_dir

require 'securerandom'
require 'set'

module MemModel
  def maglev?
    !defined?(Maglev).nil?
  end
  module_function :maglev?
end

%w[ concern base errors guid model_name rooted_base version ].each do |file|
  load File.expand_path("../mem_model/#{file}.rb", __FILE__)
end
