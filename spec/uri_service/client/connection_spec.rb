require 'spec_helper'

RSpec.describe UriService::Client::Connection do
  before do
    UriService::Client.reset! # Have to reset previously set config settings.
  end

  describe '.new' do
    context 'when api_key and url are set globally' do
      let(:connection) { described_class.new }

      before do
        UriService::Client.configure do |c|
          c.api_key = 'thebestkeptsecret'
          c.url = 'https://example.com'
        end
      end

      it 'uses previously configured url' do
        expect(connection.url).to eql 'https://example.com'
      end

      it 'uses previously configured api_key' do
        expect(connection.api_key).to eql 'thebestkeptsecret'
      end
    end

    context 'when api_key and url are defined in object instantiation' do
      let(:connection) do
        described_class.new(
          url: 'https://uriservice.com',
          api_key: 'notthebestkeptsecret'
        )
      end

      before do
        UriService::Client.configure do |c|
          c.api_key = 'thebestkeptsecret'
          c.url = 'https://example.com'
        end
      end

      it 'uses api_key set in object instance' do
        expect(connection.api_key).to eql 'notthebestkeptsecret'
      end

      it 'uses url set in object instance' do
        expect(connection.url).to eql 'https://uriservice.com'
      end
    end

    context 'when url missing' do
      let(:connection) { described_class.new(api_key: 'notthebestkeptsecret') }

      it 'raises error' do
        expect {
          connection
        }.to raise_error UriService::Client::ConfigurationError
      end
    end

    context 'when api_key missing' do
      let(:connection) { described_class.new(url: 'https://example.com') }

      it 'raises error' do
        expect {
          connection
        }.to raise_error UriService::Client::ConfigurationError
      end
    end
  end

  describe '#request' do
    include_context 'with connection'

    context 'sending a request with query parameters' do
      let(:stub) do
        stub_request(:get, "#{url}/api/v1/vocabularies")
          .with(query: { q: 'animals' })
      end

      let(:request) do
        connection.request(:get, '/vocabularies', params: { q: 'animals' })
      end

      before do
        stub
        request
      end

      it 'creates expected request' do
        expect(stub).to have_been_requested
      end
    end

    context 'sending a request with body parameters' do
      let(:body) { { string_key: 'animals', label: 'Animals' } }
      let(:stub) do
        stub_request(:post, "#{url}/api/v1/vocabularies")
          .with(
            headers: { 'Content-Type' => 'application/json' },
            body: body.to_json
          )
      end
      let(:request) do
        connection.request(:post, '/vocabularies', body: body)
      end

      before do
        stub
        request
      end

      it 'creates expected request' do
        expect(stub).to have_been_requested
      end
    end

    context 'when request returns error in body' do
      let(:body) do
        { errors: [ { title: 'Vocabulary not found' } ] }
      end
      let(:stub) do
        stub_request(:get, "#{url}/api/v1/vocabularies/does_not_exists")
          .to_return(body: body.to_json)
      end
      let(:request) { connection.request(:get, '/vocabularies/does_not_exists') }

      before do
        stub
        request
      end

      it 'creates expected request' do
        expect(stub).to have_been_requested
      end

      it 'error check returns true' do
        expect(request.errors?).to be true
      end
    end
  end

  describe '#form_fields' do
    include_context 'with connection'

    let(:stub) do
      stub_request(:get, "#{url}/api/v1/open_api_specification")
    end
    let(:form_fields) { connection.form_fields }

    before do
      stub
      form_fields
    end

    it 'requests for open api specification' do
      expect(stub).to have_been_requested
    end

    it 'return FormFields object' do
      expect(form_fields).to be_an_instance_of UriService::Client::FormFields
    end
  end
end
