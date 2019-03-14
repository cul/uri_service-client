require 'spec_helper'

RSpec.describe UriService::Client::Requests::Terms do
  include_context 'with connection'

  let(:uri) { 'http://id.worldcat.org/fast/1161301' }
  let(:encoded_uri) { CGI.escape(uri) }
  let(:term_hash) do
    {
      uuid: '756c78d5-207e-4c41-8196-b018e3eab60e',
      uri: uri,
      pref_label: 'Unicorn',
      alt_label: [],
      authority: 'fast',
      term_type: 'external'
    }
  end

  describe '#term' do
    let(:request) { connection.term('mythical_creatures', 'http://id.worldcat.org/fast/1161301') }
    let(:stub) do
      stub_request(:get, "#{url}/api/v1/vocabularies/mythical_creatures/terms/#{encoded_uri}")
        .to_return(body: term_hash.to_json, status: 200)
    end

    include_examples 'testing request'
  end

  describe '#create_term' do
    let(:request) { connection.create_term('mythical_creatures', term_hash) }
    let(:stub) do
      stub_request(:post, "#{url}/api/v1/vocabularies/mythical_creatures/terms")
        .with(body: term_hash.to_json)
        .to_return(body: term_hash.to_json, status: 201)
    end

    include_examples 'testing request'
  end

  describe '#update_term' do
    let(:request) { connection.update_term('mythical_creatures', term_hash) }
    let(:stub) do
      stub_request(:patch, "#{url}/api/v1/vocabularies/mythical_creatures/terms/#{encoded_uri}")
        .with(body: term_hash.reject { |k, _| k == :uri }.to_json)
        .to_return(body: term_hash.to_json, status: 200)
    end

    include_examples 'testing request'
  end

  describe '#delete_term' do
    let(:request) { connection.delete_term('mythical_creatures', uri) }
    let(:stub) do
      stub_request(:delete, "#{url}/api/v1/vocabularies/mythical_creatures/terms/#{encoded_uri}")
        .to_return(body: '', status: 204)
    end
    include_examples 'testing request'
  end

  describe '#search_term' do
    let(:response) do
      {
        page: 1,
        per_page: 5,
        total_records: 1,
        terms: [term_hash]
      }
    end
    let(:request) { connection.search_terms('mythical_creatures', per_page: 5, authority: 'fast') }
    let(:stub) do
      stub_request(:get, "#{url}/api/v1/vocabularies/mythical_creatures/terms")
        .with(query: { per_page: 5, authority: 'fast' })
        .to_return(body: response.to_json, status: 200)
    end

    include_examples 'testing request'
  end
end
