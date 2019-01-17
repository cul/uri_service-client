# Require simplecov/coveralls before anything else.
require 'simplecov'
require 'coveralls'

Coveralls.wear!

# Use both the coveralls formatter (for sending results to coveralls) and the
# simplecov html output to have a local display of coverage.
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]
)

SimpleCov.start

require 'bundler/setup'
require 'uri_service/client'
require 'webmock/rspec'

# Loading support files.
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
