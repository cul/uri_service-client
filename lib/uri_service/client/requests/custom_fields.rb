module UriService
  module Client
    module Requests
      module CustomFields
        def create_custom_field(vocabulary, custom_field = {})
          request(:post, "/vocabularies/#{vocabulary}/custom_fields")
        end

        def update_custom_field(vocabulary, custom_field = {})
          field_key = custom_field.delete(:field_key)
          request(:patch, "/vocabularies/#{vocabulary}/custom_fields/#{field_key}", body: custom_field)
        end

        def delete_custom_field(vocabulary, field_key)
          request(:delete, "/vocabularies/#{vocabulary}/custom_fields/#{field_key}")
        end
      end
    end
  end
end
