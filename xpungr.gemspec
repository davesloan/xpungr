# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xpungr/version'

Gem::Specification.new do |spec|
  spec.name          = 'xpungr'
  spec.version       = Xpungr::VERSION
  spec.authors       = ['Dave Sloan']
  spec.email         = ['daveksloan@gmail.com']
  spec.summary       = 'Xpungr replaces paranoia and soft-delete gems with an archival system which removes the data from your primary database and stores it in a MongoDB collection.'
  spec.description   = 'Xpungr is a Ruby gem designed to work with Rails, ActiveRecord, and Mongoid to replace paranoia and soft-delete gems with an archival system which removes the data from your primary database and stores it in a MongoDB collection.'
  spec.homepage      = 'https://github.com/davesloan/xpungr'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency('mongoid', '>= 5.1', '< 6.0')
  spec.add_dependency('rails', '>= 4.2', '< 6.0')

  spec.add_development_dependency('bundler', '>= 1.15')
  spec.add_development_dependency('rake', '>= 11.2')
  spec.add_development_dependency('rspec', '~> 3.5')
  spec.add_development_dependency('rubocop', '~> 0.67')
  spec.add_development_dependency('rubocop-performance', '~> 1.1')
  spec.add_development_dependency('rubocop-rspec', '~> 1.32')
end
