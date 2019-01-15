module UriService
  module Client
    class FormFields
      attr_reader :specification

      def initialize(response)
        @specification = response.data
      end

      def vocabulary(action)
        case action.to_s
        when 'index'
          params_for('/vocabularies', 'get')
        when 'show'
          params_for('/vocabularies/{string_key}', 'get')
        when 'create'
          params_for('/vocabularies', 'post')
        when 'update'
          params_for('/vocabularies/{string_key}', 'patch')
        when 'delete'
          params_for('/vocabularies/{string_key}', 'delete')
        end
      end

      def custom_fields(action)
        case action.to_s
        when 'create'
          params_for('/vocabularies/{string_key}/custom_fields', 'post')
        when 'update'
          params_for(
            '/vocabularies/{string_key}/custom_fields/{field_key}',
            'patch'
          )
        when 'delete'
          params_for('/vocabularies/{string_key}/custom_fields/{field_key}',
                     'delete')
        end
      end

      def term(vocabulary, action)
        case action.to_s
        when 'index'
          params_for("/vocabularies/#{vocabulary}/terms", 'get')
        when 'show'
          params_for("/vocabularies/#{vocabulary}/terms/{uri}", 'get')
        when 'create'
          params_for("/vocabularies/#{vocabulary}/terms", 'post')
        when 'update'
          params_for("/vocabularies/#{vocabulary}/terms/{uri}", 'patch')
        when 'delete'
          params_for("/vocabularies/#{vocabulary}/terms/{uri}", 'delete')
        end
      end

      private

      def params_for(path, action)
        @specification['paths'][path][action]['parameters'].keep_if do |h|
          h.key?('in') && h['in'] == 'query'
        end
      end
    end
  end
end
