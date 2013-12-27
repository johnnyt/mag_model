# MemModel [![Ver][Ver img]][Ver] [![Bld][Bld img]][Bld] [![Cov][Cov img]][Cov]

MemModel persists Ruby objects using MagLev as a data storage engine. It is an
ActiveModel compliant implementation so it works stand-alone or in Rails 3 as a
drop-in replacement for ActiveRecord or DataMapper.

If MemModel is used in non-MagLev platforms, objects will be persisted to
in-memory sets.


### Installation

Run `gem install mem_model` to install the gem on its own.

Or you can add the following to your Gemfile and run the `bundle` command to
install it.

    gem 'mem_model'


##### Development

If you'd like to work on this project first make sure you have the `hoe` gem
installed (`gem install hoe` if not), then run `rake newb` from the
`mem_model` project directory.


### Example

```ruby
require 'mem_model'

class Account
  include MemModel::Base
  attr_accessor :balance
  validates_presence_of :balance
end

checking = Account.new  #=> #<Account balance: nil, id: 17338520>
checking.valid?         #=> false
checking.balance = 100  #=> 100
checking.valid?         #=> true

checking.save           #=> 17338520
checking.new?           #=> false
Account.size            #=> 1
Account.first           #=> #<Account balance: 100, id: 17338520>
```


### Similar stuff

This stuff has been very helpful in working on MemModel.

##### Projects

* [Tesla][tesla]: MagLev niceties like models... and signs
* [Supermodel][supermodel]. Simple in-memory database using ActiveModel. Primarily
  developed for Bowline applications.
* [ActiveAttr][active_attr]: What ActiveModel left out
* [MagLevRecord][maglevrecord]: MagLev persistence with an
  ActiveRecord-like interface!

##### Docs

* [MagLev Persistence API][persistence_api]: Overview of the persistence API inMagLev
* [Persistence README][persistence_readme]: MagLev Persistence Examples overview
* [Migrations][migrations]: The Problem: Evolution of Persistent Data Formats (Schema Changes)
* [Migrations DSL][migrations_dsl]: Requirements for a Migration DSL which would allow
  "rails-like" migrations for MagLev.

##### Examples

* [Blog Data Migration Example][blog]: create a blog, add attributes, migrate existing
  instances
* [K-d Tree][kd_tree]: includes a Google Maps example using zipcodes
* [Indexing][indexing]: use unordered collections with MagLev's built-in indexing support
* [Points][points]: shows two approaches of handling data migration using a Point class.


### Contributing

If you'd like to contribute to MemModel, that's awesome. There's a guide to contributing
(both code and general help) over in [CONTRIBUTING.md](CONTRIBUTING.md)

### Development

To see what has changed in recent versions, see the [CHANGELOG.md](CHANGELOG.md).


<!--- ###################################################################### --->
<!--- ### URLs --->

[Ver]: https://rubygems.org/gems/mem_model
[Bld]: https://travis-ci.org/johnnyt/mem_model
[Cov]: https://coveralls.io/r/johnnyt/mem_model

[Ver img]: https://badge.fury.io/rb/mem_model.png
[Bld img]: https://travis-ci.org/johnnyt/mem_model.png
[Cov img]: https://coveralls.io/repos/johnnyt/mem_model/badge.png?branch=master

[hoe]: http://www.zenspider.com/projects/hoe.html

[tesla]: https://github.com/jc00ke/tesla
[supermodel]: https://github.com/maccman/supermodel
[active_attr]: https://github.com/cgriego/active_attr
[maglevrecord]: https://github.com/knub/maglevrecord

[persistence_api]: https://github.com/MagLev/maglev/blob/master-1.9/docs/persistence-api.rdoc
[persistence_readme]: https://github.com/MagLev/maglev/blob/master-1.9/examples/persistence/Persistence-README.rdoc
[migrations]: https://github.com/MagLev/maglev/blob/master-1.9/examples/persistence/migrations/migrations.org
[migrations_dsl]: https://github.com/MagLev/maglev/blob/master-1.9/examples/persistence/migrations/migration-dsl.org

[migration_examples]: https://github.com/MagLev/maglev/blob/master-1.9/examples/persistence/migrations/example/example.rdoc
[kd_tree]: https://github.com/MagLev/maglev/blob/master-1.9/examples/persistence/kdtree/KDTree-README.rdoc
[indexing]: https://github.com/MagLev/maglev/blob/master-1.9/examples/persistence/indexing/Indexing-README.rdoc
[blog]: https://github.com/MagLev/maglev/blob/master-1.9/examples/persistence/migrations/example/example.rdoc
[points]: https://github.com/MagLev/maglev/blob/master-1.9/examples/persistence/migrations/example2/README.rdoc
