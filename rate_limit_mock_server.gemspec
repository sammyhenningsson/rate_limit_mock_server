# frozen_string_literal: true

require_relative 'lib/rate_limit_mock_server/version'

Gem::Specification.new do |spec|
  spec.name          = 'rate_limit_mock_server'
  spec.version       = RateLimitMockServer::VERSION
  spec.authors       = ['Sammy Henningsson']
  spec.email         = ['sammy.henningsson@hey.com']

  spec.summary       = 'A mock server for testing out rate limiting in clients'
  spec.homepage      = 'https://github.com/sammyhenningsson/rate_limit_mock_server'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.5.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.cert_chain  = ['certs/sammyhenningsson.pem']
  spec.signing_key = File.expand_path('~/.ssh/gem-private_key.pem')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'bin'
  spec.executables   = ['rate_limit_mock_server']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'sinatra'
  spec.add_development_dependency 'minitest'
end
