# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "soundex/version"

Gem::Specification.new do |s|
  s.name        = "soundex"
  s.version     = Soundex::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Cory O'Daniel", "Adam Elhardt"]
  s.email       = ["adam@sapphireim.com"]
  s.homepage    = "http://coryodaniel.com/index.php/2009/12/30/ruby-nysiis-implementation/"
  s.summary     = %q{Ruby implementation of NYSIIS soundex algorithm}
  s.description = %q{This is a gem implementation of Cory O'Daniel's NYSIIS converter.  NYSIIS is an improved version of the soundex algorithm which allows basic phonetic searches.  For example, the nysiis string for Kathy will variant spellings like Kathey and Cathy}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
end
