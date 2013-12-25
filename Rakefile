# -*- ruby -*-

require './lib/mem_model/version'
begin
  require 'hoe'
rescue LoadError
end

desc 'Setup your local dev environment'
task :setup do
  spec = Gem::Specification::load('mem_model.gemspec')
  sh "gem install hoe-git #{spec.dependencies.map{|d| d.name}.join(' ')}"
end

desc 'Changelog'
task :changelog do
  spec = Gem::Specification::load('mem_model.gemspec')

  changes_io = StringIO.new
  $stdout = changes_io
  ENV['VERSION'] = MemModel::VERSION
  Rake::Task['git:changelog'].invoke
  $stdout = STDOUT
  changes = changes_io.string.gsub('===', '###')

  current = File.read('CHANGELOG.md')
  File.write('CHANGELOG.md', [changes, current].join)

  puts "Prepended these new changes:\n\n#{changes}"
end

desc 'Console'
task :console do
  sh "irb -rubygems -r ./lib/mem_model"
end

if defined? Hoe

[ :debug, :deps, :gemcutter, :newb, :publish, :signing ].each do |plugin|
  Hoe.plugins.delete plugin
end

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

  dependency 'minitest',            '>= 5.0.0', :development
  dependency 'minitest-reporters',  '>= 1.0.0', :development
  dependency 'coveralls',           '>= 1.0.0', :development
end

end # has_hoe

# vim: syntax=ruby
