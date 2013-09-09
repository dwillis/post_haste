# -*- encoding: utf-8 -*-
require File.expand_path('../lib/post_haste/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Derek Willis"]
  gem.email         = ["dwillis@gmail.com"]
  gem.description   = %q{A Ruby gem for accessing Washington Post articles and blog posts.}
  gem.summary       = %q{Because it was there.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "post_haste"
  gem.require_paths = ["lib"]
  gem.version       = PostHaste::VERSION
  
  gem.required_rubygems_version = ">= 1.3.6"
  gem.rubyforge_project         = "post_haste"
  gem.add_runtime_dependency "json"
  gem.add_runtime_dependency "nokogiri"
  
  gem.add_development_dependency "rake"
  gem.add_development_dependency "bundler", ">= 1.1.0"
  gem.add_development_dependency "shoulda"
  
end
