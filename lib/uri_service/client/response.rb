require 'json'

module UriService
  module Client
    class Response
      attr_reader :raw, :data, :status

      def initialize(response)
        @status = response.status
        @raw = response.body
        @data = (raw.nil? || raw.empty?) ? nil : JSON.parse(raw)
      end

      # Checks if errors are present in the response
      def errors?
        data.key?('errors') # and check status
      end
    end
  end
end
