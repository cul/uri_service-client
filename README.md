# UriService::Client

This gem is a lightweight ruby wrapper around the UriService API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uri_service-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uri_service-client

## Usage

### Configuring Connection
In order to make a connection to the URI Service API a `url` and an `api_key` are required. The following shows an example on how to set the url and api_key for every request. They can also be set on a per-connection basis. This is shown in the next section.

```ruby
UriService::Client.configure do |c|
  c.url = 'https://example.com'
  c.api_key = 'reallysecretapikey'
end
```

### Creating Connection
```ruby
# Creates connection using globally set url and api_key.
uri_service = UriService::Client.connection

# Creates connection by setting url and api_keu per connection.
uri_service = UriService::Client.connection(url: 'https://example.com', api_key: 'reallysecretapikey')
```

### Making Requests

```ruby
uri_service = UriService::Client.connection
uri_service.all_vocabularies

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/uri_service-client.
