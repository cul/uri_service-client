require 'uri_service/client/version'
require 'uri_service/client/connection'

module UriService
  module Client
    class << self
      attr_accessor :url, :api_key

      def connection(options = {})
        UriService::Client::Connection.new(options)
      end

      def configure
        yield self
      end

      def reset!
        @url = nil
        @api_key = nil
      end
    end
  end
end
