$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "middleman-behance/version"

Gem::Specification.new do |gem|
  gem.name    = "middleman-behance"
  gem.version = MiddlemanBehance::VERSION
  gem.date    = Date.today.to_s

  gem.summary = "Middleman integration of Behance API"
  gem.description = "Middleman integration of Behance API to create dynamic
    portfolios"

  gem.authors  = ["Flatstack"]
  gem.homepage = "http://github.com/fs/middleman-behance"

  gem.add_dependency("rake")

  gem.add_runtime_dependency("behance")
  gem.add_runtime_dependency("slugify", ["~> 1.0", ">= 1.0.6"])
  gem.add_runtime_dependency("middleman-core", [">= 4.1.6"])

  gem.add_development_dependency("rspec", [">= 2.0.0"])
  gem.add_development_dependency("rubocop")
  gem.add_development_dependency("bundler-audit")
  gem.add_development_dependency("pry")
  gem.add_development_dependency("pry-bloodline")
  gem.add_development_dependency("awesome_print")

  gem.require_paths = ["lib"]

  # ensure the gem is built out of versioned files
  gem.files = `git ls-files -z`.split("\0")
end
