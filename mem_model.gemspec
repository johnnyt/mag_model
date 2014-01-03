# -*- encoding: utf-8 -*-
# stub: mem_model 0.5.0.20140102213025 ruby lib

Gem::Specification.new do |s|
  s.name = "mem_model"
  s.version = "0.5.0.20140102213025"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["JohnnyT"]
  s.date = "2014-01-03"
  s.description = "MemModel persists Ruby objects using MagLev as a data storage engine. It's an ActiveModel implementation so it works stand-alone or in Rails 3 as a drop-in replacement for ActiveRecord or DataMapper.  If MemModel is used in non-MagLev platforms, objects will be persisted to in-memory sets."
  s.email = ["ubergeek3141@gmail.com"]
  s.extra_rdoc_files = ["CHANGELOG.md", "CONTRIBUTING.md", "LICENSE.md", "Manifest.txt", "README.md"]
  s.files = [".coveralls.yml", ".gitignore", ".travis.yml", "CHANGELOG.md", "CONTRIBUTING.md", "Gemfile.ci", "LICENSE.md", "Manifest.txt", "README.md", "Rakefile", "lib/mem_model.rb", "lib/mem_model/base.rb", "lib/mem_model/concern.rb", "lib/mem_model/errors.rb", "lib/mem_model/guid.rb", "lib/mem_model/model_name.rb", "lib/mem_model/rooted_base.rb", "lib/mem_model/validations.rb", "lib/mem_model/version.rb", "mem_model.gemspec", "test/helper.rb", "test/mem_model/test_active_model.rb", "test/mem_model/test_base.rb", "test/mem_model/test_guid.rb", "test/mem_model/test_rooted_base.rb", "test/mem_model/test_validations.rb", "test/mem_model/test_version.rb", "test/support/active_model_lint.rb", ".gemtest"]
  s.homepage = "https://github.com/johnnyt/mem_model"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "mem_model"
  s.rubygems_version = "2.1.11"
  s.summary = "ActiveModel-compliant MagLev persistence"
  s.test_files = ["test/mem_model/test_rooted_base.rb", "test/mem_model/test_guid.rb", "test/mem_model/test_base.rb", "test/mem_model/test_active_model.rb", "test/mem_model/test_validations.rb", "test/mem_model/test_version.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest>, [">= 5.0.0"])
      s.add_development_dependency(%q<minitest-reporters>, [">= 1.0.0"])
      s.add_development_dependency(%q<coveralls>, [">= 1.0.0"])
      s.add_development_dependency(%q<hoe>, ["~> 3.7"])
    else
      s.add_dependency(%q<minitest>, [">= 5.0.0"])
      s.add_dependency(%q<minitest-reporters>, [">= 1.0.0"])
      s.add_dependency(%q<coveralls>, [">= 1.0.0"])
      s.add_dependency(%q<hoe>, ["~> 3.7"])
    end
  else
    s.add_dependency(%q<minitest>, [">= 5.0.0"])
    s.add_dependency(%q<minitest-reporters>, [">= 1.0.0"])
    s.add_dependency(%q<coveralls>, [">= 1.0.0"])
    s.add_dependency(%q<hoe>, ["~> 3.7"])
  end
end
