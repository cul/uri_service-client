lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uri_service/client/version'

Gem::Specification.new do |spec|
  spec.name          = 'uri_service-client'
  spec.version       = UriService::Client::VERSION
  spec.authors       = ['Carla Galarza']
  spec.email         = ['cmg2228@columbia.edu']
  spec.summary       = 'Uri Service Client'
  spec.description   = 'Simple Ruby wrapper around the UriService API.'
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the
  # 'allowed_push_host' to allow pushing to a single host or delete this section
  # to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.add_runtime_dependency 'faraday', '~> 0.15.4'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.62.0'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'webmock'
end
