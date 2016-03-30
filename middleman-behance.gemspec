require File.expand_path("../lib/middleman-behance/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name    = 'middleman-behance'
  gem.version = YourGem::VERSION
  gem.date    = Date.today.to_s

  gem.summary = "Middleman integration of Behance API"
  gem.description = "Middleman integration of Behance API to create dynamic
    portfolios"

  gem.authors  = ['Flatstack']
  gem.homepage = 'http://github.com/fs/middleman_behance'

  gem.add_dependency('rake')
  gem.add_runtime_dependency('behance')
  gem.add_development_dependency('rspec', [">= 2.0.0"])
  gem.add_development_dependency('rubocop')
  gem.add_development_dependency('rubocop-rspec')
  gem.add_development_dependency('bundler-audit')

  # ensure the gem is built out of versioned files
  gem.files = Dir['Rakefile', '{bin,lib,spec}/**/*', 'README*', 'LICENSE*'] \
    & `git ls-files -z`.split("\0")
end
