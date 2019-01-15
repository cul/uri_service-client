module UriService
  module Client
    module Requests
      module Vocabularies
        def vocabularies(params = {})
          request(:get, '/vocabularies', params: params)
        end

        def vocabulary(string_key)
          request(:get, "/vocabularies/#{string_key}")
        end

        def create_vocabulary(vocabulary = {})
          request(:post, '/vocabularies', body: vocabulary)
        end

        def update_vocabulary(vocabulary = {})
          string_key = vocabulary.delete(:string_key)
          request(:patch, "/vocabularies/#{string_key}", body: vocabulary)
        end

        def delete_vocabulary(string_key)
          request(:delete, "/vocabularies/#{string_key}")
        end
      end
    end
  end
end
