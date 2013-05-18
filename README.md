# MongoMysqlRelations

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'mongo_mysql_relations'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongo_mysql_relations

## Usage

  Add MongoMySqlRelations to your models (both Active record and mongoid)

    class User < ActiveRecord::Base
      include MongoMysqlRelations

    end

  and mongoid:

    class Picture
      include Mongoid::Document
      include MongoMysqlRelations
    end

 on the mongo side you can use:
 * to_mysql_belongs_to
 * to_mysql_has_many
 * to_mysql_has_one

and on the ActiveRecord side

* from_mysql_belongs_to
* from_mysql_has_many
* from_mysql_has_one

you'll need to specify the association class and sometimes the foreign key (in `has_*` associations)

  class Picture
    include Mongoid::Document
    include MongoMysqlRelations

    to_mysql_belongs_to :user, :class => User
  end

  class User < ActiveRecord::Base
    include MongoMysqlRelations

    from_mysql_has_many :pictures, :class => Picture, :foreign_key => "user_id"
  end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
