require 'spec_helper'

RSpec.describe UriService::Client::Requests::Vocabularies do
  include_context 'with connection'

  let(:vocabulary_hash) do
    {
      string_key: 'mythical_creatures',
      label: 'Mythical Creatures',
      custom_fields: {}
    }
  end

  describe '#vocabularies' do
    let(:response) do
      {
        page: 1, per_page: 20, total_: 1,
        vocabularies: [vocabulary_hash]
      }
    end
    let(:request) { connection.vocabularies }
    let(:stub) do
      stub_request(:get, "#{url}/api/v1/vocabularies")
        .to_return(body: response.to_json, status: 200)
    end

    include_examples 'testing request'
  end

  describe '#vocabulary' do
    let(:request) { connection.vocabulary('mythical_creatures') }
    let(:stub) do
      stub_request(:get, "#{url}/api/v1/vocabularies/mythical_creatures")
        .to_return(body: vocabulary_hash.to_json, status: 200)
    end

    include_examples 'testing request'
  end

  describe '#create_vocabulary' do
    let(:request) { connection.create_vocabulary(vocabulary_hash) }
    let(:stub) do
      stub_request(:post, "#{url}/api/v1/vocabularies")
        .with(body: vocabulary_hash.to_json)
        .to_return(body: vocabulary_hash.to_json, status: 201)
    end

    include_examples 'testing request'
  end

  describe '#update_vocabulary' do
    let(:request) { connection.update_vocabulary(vocabulary_hash) }
    let(:stub) do
      stub_request(:patch, "#{url}/api/v1/vocabularies/mythical_creatures")
        .with(body: { label: 'Mythical Creatures', custom_fields: {} }.to_json)
        .to_return(body: vocabulary_hash.to_json, status: 200)
    end

    include_examples 'testing request'
  end

  describe '#delete_vocabulary' do
    let(:request) { connection.delete_vocabulary('mythical_creatures') }
    let(:stub) do
      stub_request(:delete, "#{url}/api/v1/vocabularies/mythical_creatures")
        .to_return(body: '', status: 204)
    end

    include_examples 'testing request'
  end
end
