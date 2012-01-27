require File.expand_path("../lib/version", __FILE__)

Gem::Specification.new do |s|
  s.name          = "isbn13"
  s.version       = ISBN13::VERSION
  s.authors       = ["Luis Parravicini"]
  s.email         = ["lparravi@gmail.com"]
  s.homepage      = "http://github.com/luisparravicini/isbn13"
  s.summary       = "A library for validating and properly formatting ISBN13 numbers"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.require_paths = ["lib"]
  s.description   = "Provides validation and proper formatting for ISBN13 numbers."
end
