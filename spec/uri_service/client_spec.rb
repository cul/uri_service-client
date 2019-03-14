RSpec.describe UriService::Client do
  it 'has a version number' do
    expect(UriService::Client::VERSION).not_to be nil
  end

  describe '.connection' do
    before do
      described_class.configure do |c|
        c.api_key = 'thebestkeptsecret'
        c.url = 'https://example.com'
      end
    end

    it 'can create connection object' do
      expect(described_class.connection).to be_an_instance_of UriService::Client::Connection
    end
  end

  describe '.configure' do
    before do
      described_class.configure do |c|
        c.api_key = 'thebestkeptsecret'
        c.url = 'https://example.com'
      end
    end

    it 'stores url' do
      expect(described_class.url).to eql 'https://example.com'
    end

    it 'store api_key' do
      expect(described_class.api_key).to eql 'thebestkeptsecret'
    end
  end
end
