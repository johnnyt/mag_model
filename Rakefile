# -*- ruby -*-

#require 'rubygems'
require 'hoe'

Hoe.plugin :git
Hoe.plugin :gemspec

Hoe.spec 'mem_model' do
  developer 'JohnnyT', 'ubergeek3141@gmail.com'

  self.summary     = 'ActiveModel-compliant MagLev persistence'
  self.description = <<-DESC.strip.gsub(/\n\s+/, " ")
    MemModel persists Ruby objects using MagLev as a data storage engine. It's an
    ActiveModel implementation so it works stand-alone or in Rails 3 as a drop-in
    replacement for ActiveRecord or DataMapper.  If MemModel is used in non-MagLev
    platforms, objects will be persisted to in-memory sets.
  DESC
  self.urls        = ['https://github.com/johnnyt/mem_model']

  self.history_file = 'CHANGELOG.md'
  self.readme_file  = 'README.md'
  self.testlib      = :none # actually minitest. this helps the gem to be loaded

  license 'MIT'

  dependency 'active_attr',   '>= 0.8.2'
  dependency 'activesupport', '= 3.2.15' # MagLev optimized version

  dependency 'minitest',            '>= 5.0.0', :development
  dependency 'minitest-reporters',  '>= 1.0.0', :development
  dependency 'coveralls',           '>= 1.0.0', :development
end

# vim: syntax=ruby
