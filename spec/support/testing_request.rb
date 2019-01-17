# Shared snipped between tests that check for the correct request.
shared_examples 'testing request' do
  before { stub }

  it 'created correct request' do
    request
    expect(stub).to have_been_requested
  end

  it 'returns response object' do
    expect(request).to be_an_instance_of UriService::Client::Response
  end
end

shared_context 'with connection' do
  let(:url) { 'https://example.com' }
  let(:api_key) { 'thebestkeptsecret' }
  let(:connection) { UriService::Client.connection(url: url, api_key: api_key) }
end
