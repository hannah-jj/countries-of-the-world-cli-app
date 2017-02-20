# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'countries_of_the_world/version'

Gem::Specification.new do |spec|
  spec.name          = "countries_of_the_world"
  spec.version       = CountriesOfTheWorld::VERSION
  spec.authors       = ["Hannah Jiang"]
  spec.email         = ["hui1021@gmail.com"]

  spec.summary       = "To provide basic information on each country of the world"
  spec.description   = "To provide basic information such as region, population, GDP etc. for each country found in worldbank database"
  spec.homepage      = "https://github.com/hannah11361/countries-of-the-world-cli-app"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  #spec.bindir        = "exe"
  spec.executables   << 'countries_of_the_world'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "nokogiri"
  spec.add_dependency "colorize"
  spec.add_development_dependency "pry"
end
