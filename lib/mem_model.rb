lib_dir = File.dirname(__FILE__)
$LOAD_PATH << lib_dir unless $LOAD_PATH.include? lib_dir

require 'set'

module MemModel
  def maglev?
    !defined?(Maglev).nil?
  end

  def commit
    maglev? ? Maglev.commit_transaction : true
  end

  def abort
    maglev? ? Maglev.abort_transaction : true
  end

  def persistent(&block)
    if maglev?
      Maglev.persistent{ block.call }
      #Maglev.commit_transaction
    else
      block.call
    end
  end

  module_function :maglev?, :commit, :abort, :persistent
end

%w[ concern base errors guid model_name rooted_base validations version ].each do |file|
  load File.expand_path("../mem_model/#{file}.rb", __FILE__)
end
