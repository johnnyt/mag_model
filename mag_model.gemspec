# -*- encoding: utf-8 -*-
# stub: mag_model 0.1.0.20131219143022 ruby lib

Gem::Specification.new do |s|
  s.name = "mag_model"
  s.version = "0.1.0.20131219143022"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["JohnnyT"]
  s.date = "2013-12-19"
  s.description = "MagModel persists Ruby objects using MagLev as a data storage engine. It's an ActiveModel implementation so it works stand-alone or in Rails 3 as a drop-in replacement for ActiveRecord or DataMapper.  If MagModel is used in non-MagLev platforms, objects will be persisted to in-memory sets."
  s.email = ["ubergeek3141@gmail.com"]
  s.extra_rdoc_files = ["CHANGELOG.md", "CONTRIBUTING.md", "LICENSE.md", "Manifest.txt", "README.md"]
  s.files = ["CHANGELOG.md", "CONTRIBUTING.md", "LICENSE.md", "Manifest.txt", "README.md", "Rakefile", "lib/mag_model.rb", "lib/mag_model/base.rb", "lib/mag_model/version.rb", "mag_model.gemspec", "test/helper.rb", "test/mag_model/test_active_model_lint.rb", "test/mag_model/test_base.rb", "test/mag_model/test_persistence.rb", "test/test_version.rb", ".gemtest"]
  s.homepage = "https://github.com/johnnyt/mag_model"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "mag_model"
  s.rubygems_version = "2.1.11"
  s.summary = "ActiveModel-compliant MagLev persistence"
  s.test_files = ["test/mag_model/test_active_model_lint.rb", "test/mag_model/test_base.rb", "test/mag_model/test_persistence.rb", "test/test_version.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<active_attr>, [">= 0.8.2"])
      s.add_runtime_dependency(%q<activesupport>, ["= 3.2.15"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_development_dependency(%q<minitest>, ["= 5.0.2"])
      s.add_development_dependency(%q<hoe>, ["~> 3.7"])
    else
      s.add_dependency(%q<active_attr>, [">= 0.8.2"])
      s.add_dependency(%q<activesupport>, ["= 3.2.15"])
      s.add_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_dependency(%q<minitest>, ["= 5.0.2"])
      s.add_dependency(%q<hoe>, ["~> 3.7"])
    end
  else
    s.add_dependency(%q<active_attr>, [">= 0.8.2"])
    s.add_dependency(%q<activesupport>, ["= 3.2.15"])
    s.add_dependency(%q<rdoc>, ["~> 4.0"])
    s.add_dependency(%q<minitest>, ["= 5.0.2"])
    s.add_dependency(%q<hoe>, ["~> 3.7"])
  end
end
