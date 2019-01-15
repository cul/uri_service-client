require 'uri_service/client/response'

module UriService
  module Client
    module Requests
      module Terms
        def term(vocabulary, uri)
          request(:get, "/vocabularies/#{vocabulary}/terms/#{uri}")
        end

        def create_term(vocabulary, term = {})
          request(:post, "/vocabularies/#{vocabulary}/terms", body: term)
        end

        def update_term(vocabulary, term = {})
          uri = term.delete('uri')
          request(:patch,
                  "/vocabularies/#{vocabulary}/terms/#{uri}",
                  body: term)
        end

        def delete_term(vocabulary, uri)
          request(:delete, "/vocabularies/#{vocabulary}/terms/#{uri}")
        end

        def search_terms(vocabulary, search_params = {})
          request(:get,
                  "/vocabularies/#{vocabulary}/terms",
                  params: search_params)
        end
        alias terms search_terms
      end
    end
  end
end
