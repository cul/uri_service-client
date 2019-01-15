require 'faraday'
require 'uri_service/client/error'
require 'uri_service/client/form_fields'
require 'uri_service/client/requests/custom_fields'
require 'uri_service/client/requests/terms'
require 'uri_service/client/requests/vocabularies'

module UriService
  module Client
    class Connection
      include UriService::Client::Requests::Terms
      include UriService::Client::Requests::Vocabularies
      include UriService::Client::Requests::CustomFields

      attr_reader :connection

      BASE_PATH = '/api/v1'.freeze

      def initialize(url: nil, api_key: nil)
        url ||= UriService::Client.url
        api_key ||= UriService::Client.api_key

        raise 'Missing UriService::Client.url.' if url.nil? || url.empty?

        if api_key.nil? || api_key.empty?
          raise 'Missing UriService::Client.api_key.'
        end

        @connection = Faraday.new(url: url) do |conn|
          conn.request    :url_encoded # form-encode POST params
          conn.token_auth api_key

          # Must be the last middleware, must be set.
          conn.adapter    Faraday.default_adapter
        end
      end

      def request(method, path, body: {}, params: {})
        response = connection.send(method, "#{BASE_PATH}#{path}") do |r|
          unless body.nil? || body.empty?
            r.body = body.to_json
            r.headers['Content-Type'] = 'application/json'
          end

          params.each { |k, v| r.params[k] = v }
        end

        UriService::Client::Response.new(response)
      rescue StandardError
        raise UriService::Client::Error
      end

      def form_fields
        response = request(:get, '/open_api_specification')
        UriService::Client::FormFields.new(response)
      rescue StandardError
        raise UriService::Client::Error
      end
    end
  end
end