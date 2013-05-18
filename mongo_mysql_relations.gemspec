# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongo_mysql_relations/version'

Gem::Specification.new do |spec|
  spec.name          = "mongo_mysql_relations"
  spec.version       = MongoMysqlRelations::VERSION
  spec.authors       = ["eladmeidar"]
  spec.email         = ["elad@eizesus.com"]
  spec.description   = %q{A mongoid to mysql and vice versa association manager}
  spec.summary       = %q{Allows you to create associations between mongoid based models and activerecord based models}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "mongoid"
  spec.add_dependency "bson_ext"
end
