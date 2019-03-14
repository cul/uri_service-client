require 'spec_helper'

RSpec.describe UriService::Client::Requests::CustomFields do
  include_context 'with connection'

  let(:field_key) { 'harry_potter_reference' }
  let(:custom_field_hash) do
    {
      field_key: field_key,
      data_type: 'boolean',
      label: 'Harry Potter Reference'
    }
  end

  describe 'create_custom_field' do
    let(:request) { connection.create_custom_field('mythical_creatures', custom_field_hash) }
    let(:stub) do
      stub_request(:post, "#{url}/api/v1/vocabularies/mythical_creatures/custom_fields")
        .with(body: custom_field_hash.to_json)
        .to_return(body: custom_field_hash.to_json, status: 201)
    end

    include_context 'testing request'
  end

  describe 'update_custom_field' do
    let(:request) { connection.update_custom_field('mythical_creatures', custom_field_hash) }
    let(:stub) do
      stub_request(:patch, "#{url}/api/v1/vocabularies/mythical_creatures/custom_fields/#{field_key}")
        .with(body: custom_field_hash.reject { |k, _| k == :field_key })
        .to_return(body: custom_field_hash.to_json, status: 200)
    end

    include_context 'testing request'
  end

  describe 'delete_custom_field' do
    let(:request) { connection.delete_custom_field('mythical_creatures', field_key) }
    let(:stub) do
      stub_request(:delete, "#{url}/api/v1/vocabularies/mythical_creatures/custom_fields/#{field_key}")
        .to_return(body: '', status: 204)
    end

    include_context 'testing request'
  end
end
