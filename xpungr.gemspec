# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xpungr/version'

Gem::Specification.new do |spec|
  spec.name          = 'xpungr'
  spec.version       = Xpungr::VERSION
  spec.authors       = ['Dave Sloan']
  spec.email         = ['daveksloan@gmail.com']
  spec.summary       = 'Yet another ActiveRecord soft-delete gem with option to archive.'
  spec.description   = 'Xpungr is a Ruby gem designed to work with Rails and ActiveRecord to provide a way of soft-deleting records. Rather than using the usual method of a nullable deleted_at field, xpungr give you the option of using a boolean flag or archiving the deleted record into a separate database table. Either method should result in better scalability as data and soft-deleted data grows within your application.'
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

  spec.add_dependency('activerecord', '>= 4.2.8', '< 6.0')
  spec.add_dependency('activesupport', '>= 4.2.8', '< 6.0')

  spec.add_development_dependency('bundler', '>= 1.15')
  spec.add_development_dependency('rake', '>= 11.2')
  spec.add_development_dependency('rspec', '~> 3.5')
  spec.add_development_dependency('rubocop', '~> 0.67')
  spec.add_development_dependency('rubocop-rspec', '~> 1.32')
end
