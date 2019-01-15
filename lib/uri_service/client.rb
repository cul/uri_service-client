require 'uri_service/client/version'
require 'uri_service/client/connection'

module UriService
  module Client
    class << self
      attr_accessor :url, :api_key

      def connection
        UriService::Client::Connection.new
      end

      def configure
        yield self
      end
    end
  end
end
